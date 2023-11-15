import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:chaldea/app/api/chaldea.dart';
import 'package:chaldea/app/app.dart';
import 'package:chaldea/app/modules/battle/formation/formation_card.dart';
import 'package:chaldea/app/modules/home/subpage/login_page.dart';
import 'package:chaldea/generated/l10n.dart';
import 'package:chaldea/models/api/api.dart';
import 'package:chaldea/models/models.dart';
import 'package:chaldea/packages/app_info.dart';
import 'package:chaldea/packages/logger.dart';
import 'package:chaldea/utils/catcher/server_feedback_handler.dart';
import 'package:chaldea/utils/utils.dart';
import 'package:chaldea/widgets/widgets.dart';
import '../../common/filter_page_base.dart';
import '../utils.dart';
import 'filter.dart';

enum TeamQueryMode { user, quest, id }

class TeamsQueryPage extends StatefulWidget {
  final TeamQueryMode mode;
  final Quest? quest;
  final BattleQuestInfo? phaseInfo;
  final List<int>? teamIds;
  final String? userId; // name or id

  const TeamsQueryPage({super.key, required this.mode, this.quest, this.phaseInfo, this.teamIds, this.userId});

  @override
  State<TeamsQueryPage> createState() => _TeamsQueryPageState();
}

class _TeamsQueryPageState extends State<TeamsQueryPage> with SearchableListState<UserBattleData, TeamsQueryPage> {
  static const _pageSize = 200;
  final secrets = db.settings.secrets;
  int? get curUserId => secrets.user?.id;

  TeamQueryMode get mode => widget.mode;

  int pageIndex = 0;
  TeamQueryResult queryResult = TeamQueryResult(data: []);
  final filterData = TeamFilterData();

  @override
  Iterable<UserBattleData> get wholeData => queryResult.data;

  @override
  void initState() {
    super.initState();
    _queryTeams(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    filterShownList();
    return scrollListener(useGrid: false, appBar: appBar);
  }

  PreferredSizeWidget? get appBar {
    final username = widget.userId ?? secrets.user?.name ?? "Not Login";
    return AppBar(
      title: Text.rich(TextSpan(
        children: [
          if (mode == TeamQueryMode.user) TextSpan(text: '${S.current.team} @$username'),
          if (mode == TeamQueryMode.quest && widget.quest != null)
            TextSpan(text: '${S.current.team} - ${widget.quest?.lDispName.breakWord}'),
          if (mode == TeamQueryMode.id) TextSpan(text: S.current.team_shared),
        ],
      )),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_alt),
          tooltip: S.current.filter,
          onPressed: () {
            Set<int> svtIds = {}, ceIds = {};
            for (final record in queryResult.data) {
              final svts = record.decoded?.team.allSvts ?? [];
              svtIds.addAll(svts.map((e) => e?.svtId ?? 0).where((e) => e > 0));
              ceIds.addAll(svts.map((e) => e?.ceId ?? 0).where((e) => e > 0));
            }
            return FilterPage.show(
              context: context,
              builder: (context) => TeamFilter(
                filterData: filterData,
                availableSvts: svtIds,
                availableCEs: ceIds,
                onChanged: (_) {
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget? get buttonBar {
    final List<Widget> buttons;
    if (widget.mode == TeamQueryMode.user && !secrets.isLoggedIn) {
      buttons = [
        ElevatedButton(
          onPressed: () async {
            await router.pushPage(LoginPage());
            if (mounted) setState(() {});
          },
          child: Text(S.current.login_login),
        ),
      ];
    } else {
      String rangeHint;
      if (queryResult.data.isEmpty && queryResult.offset == 0 && (queryResult.total ?? 0) == 0) {
        rangeHint = '-';
      } else {
        rangeHint = MaterialLocalizations.of(context).pageRowsInfoTitle(
          queryResult.offset + 1,
          queryResult.offset + queryResult.data.length,
          queryResult.total ?? -1,
          false,
        );
      }
      buttons = [
        Text(
          rangeHint,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: pageIndex == 0 ? null : () => _queryTeams(pageIndex - 1),
          style: kTextButtonDenseStyle,
          child: Text(S.current.prev_page),
        ),
        TextButton(
          onPressed: !queryResult.hasNextPage ? null : () => _queryTeams(pageIndex + 1),
          style: kTextButtonDenseStyle,
          child: Text(S.current.next_page),
        ),
        TextButton(
          onPressed: () async {
            EasyThrottle.throttle('team_query_refresh', const Duration(seconds: 2), () {
              _queryTeams(pageIndex, refresh: true);
            });
          },
          style: kTextButtonDenseStyle,
          child: Text(S.current.refresh),
        ),
      ];
    }

    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: SizedBox(
        height: 48,
        child: ListView(
          reverse: true,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
          children: [
            for (final child in buttons.reversed) Center(child: child),
          ],
        ),
      ),
    );
  }

  @override
  Widget listItemBuilder(UserBattleData record) {
    final index = queryResult.data.indexOf(record);
    final shareData = record.decoded;
    final quest = db.gameData.quests[record.questId];
    final shownIndex = _pageSize * pageIndex + index + 1;
    final extraInfo = getExtraInfo(record);

    Widget child = Column(
      children: [
        const SizedBox(height: 6),
        _getHeader(shownIndex, record),
        if (extraInfo.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(children: extraInfo),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
                fontSize: 14,
              ),
            ),
          ),
        if (widget.mode == TeamQueryMode.user || widget.mode == TeamQueryMode.id)
          ListTile(
            dense: true,
            leading: db.getIconImage(quest?.spot?.shownImage, width: 24),
            minLeadingWidth: 24,
            title: Text(quest?.lDispName ?? "Quest ${record.questId}/${record.phase}"),
            trailing: Icon(DirectionalIcons.keyboard_arrow_forward(context)),
            onTap: () {
              router.push(url: Routes.questI(record.questId, record.phase));
            },
          ),
        if (shareData != null) FormationCard(formation: shareData.team),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 2,
          children: [
            if (widget.mode != TeamQueryMode.user)
              IconButton(
                onPressed: () {
                  setState(() {
                    db.curUser.battleSim.favoriteTeams.putIfAbsent(record.questId, () => {}).toggle(record.id);
                  });
                },
                icon: db.curUser.battleSim.isTeamFavorite(record.questId, record.id)
                    ? const Icon(Icons.star, color: Colors.amber)
                    : const Icon(Icons.star_border, color: Colors.grey),
                tooltip: S.current.favorite,
              ),
            if (mode == TeamQueryMode.user || record.userId == curUserId || AppInfo.isDebugDevice)
              FilledButton(
                onPressed: () {
                  final isOthers = record.userId != curUserId;
                  SimpleCancelOkDialog(
                    title: Text(S.current.confirm),
                    content: Text([
                      '${S.current.delete} No.${record.id}',
                      if (isOthers) "Waring: ${record.userId}'s, not your team",
                    ].join('\n')),
                    onTapOk: () {
                      _deleteUserTeam(record);
                    },
                  ).showDialog(context);
                },
                style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
                child: Text(S.current.delete),
              ),
            if (shareData != null)
              FilledButton(
                onPressed: () {
                  replaySimulation(detail: shareData, questInfo: record.questInfo);
                },
                child: Text(S.current.details),
              ),
            if (mode == TeamQueryMode.quest)
              FilledButton(
                onPressed: shareData == null
                    ? null
                    : () {
                        Navigator.pop(context, shareData.team);
                      },
                child: Text(S.current.select),
              ),
            IconButton(
              onPressed: shareData == null
                  ? null
                  : () => showDialog(
                        context: context,
                        useRootNavigator: false,
                        builder: (context) => buildShareDialog(context, record),
                      ),
              icon: const Icon(Icons.ios_share),
              tooltip: S.current.share,
            )
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
    return Material(
      color: shownList.indexOf(record).isOdd ? Theme.of(context).hoverColor : null,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 80 * 8),
          child: child,
        ),
      ),
    );
  }

  Widget _getHeader(int index, UserBattleData record) {
    final themeData = Theme.of(context);
    final style = themeData.textTheme.bodySmall;
    Future<void> onVote(bool isUpVote) async {
      if (!secrets.isLoggedIn) return;
      record.tempVotes ??= record.votes.copy();
      record.tempVotes!.updateMyVote(isUpVote);
      if (mounted) setState(() {});
      EasyDebounce.debounce(
        'team_vote_${record.id}',
        const Duration(seconds: 1),
        () async {
          final result =
              await ChaldeaWorkerApi.teamVote(teamId: record.id, voteValue: (record.tempVotes ?? record.votes).mine);
          record.tempVotes = null;
          if (result != null) {
            record.votes = result;
            ChaldeaWorkerApi.clearTeamCache();
          }
          if (mounted) setState(() {});
        },
      );
    }

    final votes = record.tempVotes ?? record.votes;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            [
              '${S.current.team} $index - ${record.username ?? "User ${record.userId}"} [${record.id}]',
              if (widget.phaseInfo?.enemyHash == null) '${S.current.version} ${record.enemyHash.substring2(2)}',
            ].join('\n'),
            style: style,
          ),
        ),
        if (record.decoded?.options.simulateAi == true)
          Tooltip(
            message: S.current.simulate_simple_ai,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(Icons.smart_toy_outlined, size: 18, color: Theme.of(context).colorScheme.primary),
            ),
          ),
        InkWell(
          onTap: secrets.isLoggedIn ? () => onVote(true) : null,
          child: Icon(
            Icons.thumb_up_alt,
            size: 16,
            color: votes.mine == 1 ? themeData.colorScheme.primary : themeData.unselectedWidgetColor,
          ),
        ),
        Text(votes.up.toString().padRight(4, ' '), style: style),
        InkWell(
          onTap: secrets.isLoggedIn ? () => onVote(false) : null,
          child: Icon(
            Icons.thumb_down_alt,
            size: 16,
            color: votes.mine == -1 ? themeData.colorScheme.primaryContainer : themeData.unselectedWidgetColor,
          ),
        ),
        Text(votes.down.toString().padRight(6, ' '), style: style),
        InkWell(
          onTap: () {
            ReportTeamDialog(record: record).showDialog(context);
          },
          child: Icon(
            Icons.report_outlined,
            size: 18,
            color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.8),
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  List<InlineSpan> getExtraInfo(UserBattleData record) {
    List<InlineSpan> spans = [];
    final team = record.decoded;
    if (team == null) return spans;
    final maxRandom = Maths.max(team.actions.map((e) => e.options.random));
    if (maxRandom > ConstData.constants.attackRateRandomMin) {
      spans.add(TextSpan(text: '${S.current.random} ${maxRandom / 1000}'));
    }
    final minThreshold = Maths.min(team.actions.map((e) => e.options.threshold));
    if (minThreshold < 1000) {
      spans.add(
          TextSpan(text: '${S.current.battle_probability_threshold} ${minThreshold.format(percent: true, base: 10)}'));
    }
    final normalAttackCount = team.normalAttackCount;
    if (normalAttackCount > 0) {
      spans.add(TextSpan(text: '$normalAttackCount ${S.current.battle_command_card}'));
    }

    // team.options.pointBuffs;
    final enemyRateUp = team.options.enemyRateUp?.toList() ?? [];
    if (enemyRateUp.isNotEmpty) {
      for (final indiv in enemyRateUp) {
        spans.add(TextSpan(children: [
          CenterWidgetSpan(
            child: db.getIconImage(
              AssetURL.i.buffIcon(Theme.of(context).isDarkMode ? 1014 : 1015),
              width: 18,
              height: 18,
            ),
          ),
          TextSpan(text: Transl.trait(indiv).l),
        ]));
      }
    }

    spans = divideList(spans, const TextSpan(text: ', '));
    return spans;
  }

  @override
  Widget gridItemBuilder(UserBattleData record) {
    throw UnimplementedError("Do not support GridView");
  }

  @override
  bool filter(UserBattleData record) {
    final data = record.decoded;
    if (data == null) return true;
    if (filterData.favorite && !db.curUser.battleSim.isTeamFavorite(record.questId, record.id)) {
      return false;
    }
    for (final svtId in filterData.blockSvts.options) {
      if (data.team.allSvts.any((svt) => svt?.svtId == svtId)) {
        return false;
      }
    }
    if (filterData.useSvts.options.isNotEmpty &&
        !filterData.useSvts.options.every((svtId) => data.team.allSvts.any((e) => e?.svtId == svtId))) {
      return false;
    }

    bool _isCEMismatch(SvtSaveData? svt, int ceId) {
      if (svt == null || (svt.svtId ?? 0) <= 0) return false;
      if (svt.ceId != ceId) return false;
      final mlbOnly = filterData.blockCEMLBOnly[ceId] ?? false;
      return mlbOnly ? svt.ceLimitBreak : true;
    }

    for (final ceId in filterData.blockCEs.options) {
      if (data.team.allSvts.any((svt) => _isCEMismatch(svt, ceId))) {
        return false;
      }
    }

    final attackerTdCard = filterData.attackerTdCardType.radioValue;
    if (attackerTdCard != null) {
      final tdCheck = data.containsTdCardType(attackerTdCard);
      if (tdCheck == false) {
        return false;
      }
    }

    int maxNormalAttackCount = filterData.normalAttackCount.radioValue!;
    int maxCriticalAttackCount = filterData.criticalAttackCount.radioValue!;

    if (maxNormalAttackCount >= 0 || maxCriticalAttackCount >= 0) {
      int normalAttackCount = data.normalAttackCount;
      if (maxNormalAttackCount >= 0 && normalAttackCount > maxNormalAttackCount) {
        return false;
      }

      int criticalAttackCount = data.critsCount;
      if (maxCriticalAttackCount >= 0 && criticalAttackCount > maxCriticalAttackCount) {
        return false;
      }
    }

    for (final miscOption in filterData.miscOptions.options) {
      switch (miscOption) {
        case TeamFilterMiscType.noOrderChange:
          if ([20, 210].contains(data.team.mysticCode.mysticCodeId) && data.usedMysticCodeSkill(2) == true) {
            return false;
          }
        case TeamFilterMiscType.noSameSvt:
          final svtIds = data.team.allSvts.map((e) => e?.svtId ?? 0).where((e) => e > 0).toList();
          if (svtIds.length != svtIds.toSet().length) {
            return false;
          }
        case TeamFilterMiscType.noAppendSkill:
          for (final svt in data.team.allSvts) {
            final dbSvt = db.gameData.servantsById[svt?.svtId];
            if (svt == null || dbSvt == null) continue;
            if (svt.appendLvs.any((lv) => lv > 0)) {
              return false;
            }
          }
        case TeamFilterMiscType.noGrailFou:
          for (final svt in data.team.allSvts) {
            final dbSvt = db.gameData.servantsById[svt?.svtId];
            if (svt == null || dbSvt == null) continue;
            if (dbSvt.type != SvtType.heroine && svt.lv > dbSvt.lvMax) {
              return false;
            }
            if (svt.hpFou > 1000 || svt.atkFou > 1000) {
              return false;
            }
          }
        case TeamFilterMiscType.noLv100:
          for (final svt in data.team.allSvts) {
            final dbSvt = db.gameData.servantsById[svt?.svtId];
            if (svt == null || dbSvt == null) continue;
            if (svt.lv > 100) {
              return false;
            }
          }
          break;
      }
    }
    return true;
  }

  Future<void> _queryTeams(final int page, {bool refresh = false}) async {
    if (widget.mode == TeamQueryMode.user && !secrets.isLoggedIn) return;
    Future<TeamQueryResult?> task;
    switch (mode) {
      case TeamQueryMode.user:
        final userId = widget.userId != null ? int.tryParse(widget.userId!) : null;
        task = showEasyLoading(() => ChaldeaWorkerApi.teamsByUser(
              limit: _pageSize,
              offset: _pageSize * page,
              expireAfter: refresh ? Duration.zero : const Duration(days: 2),
              userId: userId,
              username: widget.userId,
            ));
      case TeamQueryMode.quest:
        final quest = widget.quest;
        final phase = widget.phaseInfo?.phase ?? quest?.phases.lastOrNull;
        if (quest == null || !quest.isLaplaceSharable || phase == null) return;
        task = showEasyLoading(() => ChaldeaWorkerApi.teamsByQuest(
              questId: quest.id,
              phase: phase,
              enemyHash: widget.phaseInfo?.enemyHash,
              limit: _pageSize,
              offset: _pageSize * page,
              expireAfter: refresh ? Duration.zero : null,
            ));
      case TeamQueryMode.id:
        task = showEasyLoading(() async {
          final teams = <UserBattleData>[];
          for (final id in widget.teamIds ?? <int>[]) {
            final team = await ChaldeaWorkerApi.team(id, expireAfter: refresh ? Duration.zero : null);
            if (team != null) teams.add(team);
          }
          return TeamQueryResult(offset: 0, limit: teams.length, total: teams.length, data: teams);
        });
    }
    TeamQueryResult? result = await task;
    if (result != null) {
      result.data.sortByList((e) => [
            e.userId == curUserId ? 0 : 1,
            db.curUser.battleSim.favoriteTeams[e.questId]?.contains(e.id) == true ? 0 : 1,
            -e.votes.up + e.votes.down,
            e.id,
          ]);
      for (final r in result.data) {
        r.parse();
      }
      queryResult = result;
      pageIndex = page;
    }
    if (mounted) setState(() {});
  }

  Future<void> _deleteUserTeam(UserBattleData battleRecord) async {
    if (!secrets.isLoggedIn) return;
    final resp = await showEasyLoading(() => ChaldeaWorkerApi.teamDelete(id: battleRecord.id));
    if (resp == null) return;
    queryResult.data.remove(battleRecord);
    ChaldeaWorkerApi.clearTeamCache();
    resp.showToast();
    if (mounted) setState(() {});
  }

  Widget buildShareDialog(BuildContext context, UserBattleData record) {
    final urls = <String?>[
      record.toShortUri().toString(),
      record.toUriV2().toString(),
    ].whereType<String>().toList();

    return SimpleDialog(
      title: Text(S.current.share),
      children: [
        for (int index = 0; index < urls.length; index++)
          ListTile(
            dense: true,
            horizontalTitleGap: 8,
            minLeadingWidth: 16,
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            leading: Text((index + 1).toString()),
            title: Text(
              urls[index],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              copyToClipboard(urls[index]);
              EasyLoading.showToast(S.current.copied);
              Navigator.pop(context);
            },
          ),
        ListTile(
          dense: true,
          horizontalTitleGap: 8,
          minLeadingWidth: 16,
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          leading: Text(3.toString()),
          title: const Text(
            "Copy Replay Steps",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            db.runtimeData.clipBoard.teamData = record;
            EasyLoading.showToast(S.current.copied);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class ReportTeamDialog extends StatefulWidget {
  final UserBattleData record;
  const ReportTeamDialog({super.key, required this.record});

  @override
  State<ReportTeamDialog> createState() => _ReportTeamDialogState();
}

class _ReportTeamDialogState extends State<ReportTeamDialog> {
  late final UserBattleData record = widget.record;
  late final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleCancelOkDialog(
      scrollable: true,
      title: Text(S.current.about_feedback),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            dense: true,
            title: Text(S.current.team),
            contentPadding: EdgeInsets.zero,
            trailing: Text(
              "No.${record.id}\n@${record.username ?? record.userId}",
              textScaleFactor: 0.8,
              textAlign: TextAlign.end,
            ),
            subtitle: Text(
              [
                record.createdAt.sec2date().toDateString(),
                if ((record.appVer ?? "").isNotEmpty) record.appVer,
              ].join('  '),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: S.current.delete_reason,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: S.current.team_report_reason_hint,
            ),
            style: const TextStyle(fontSize: 14),
            maxLines: 5,
          ),
        ],
      ),
      hideOk: true,
      actions: [
        TextButton(
          onPressed: onSend,
          child: Text(S.current.feedback_send),
        ),
      ],
    );
  }

  Future<void> onSend() async {
    final reason = controller.text.trim();
    if (reason.isEmpty) {
      EasyLoading.showInfo(S.current.empty_hint);
      return;
    }

    try {
      String subject = '[Team] ${reason.substring2(0, 20)}';

      final handler = ServerFeedbackHandler(
        emailTitle: subject,
        senderName: 'Team Report',
      );

      final buffer = StringBuffer();
      final quest = db.gameData.quests[record.questId];
      buffer.writeAll([
        "Quest: https://apps.atlasacademy.io/db/JP/quest/${record.questId}/${record.phase}?hash=${record.enemyHash}",
        "Lv. ${quest?.recommendLv} ${quest?.name}",
        "Spot: ${quest?.spotName}",
        "War: ${quest?.war?.longName.setMaxLines(1)}",
        "Team: https://worker.chaldea.center/api/v4/team/${record.id}?decode=1",
        "Version: ${record.ver}",
        "ID: ${record.id}",
        "Uploader: ${record.username}",
        // "Stars: x up, y down\n",
        "Reporter: ${db.settings.secrets.user?.name}",
        "Reason:\n$reason"
      ], '\n');

      final result = await showEasyLoading(() => handler.handle(FeedbackReport(null, buffer.toString()), null));
      if (!result) {
        throw S.current.sending_failed;
      }
      EasyLoading.showSuccess(S.current.sent);
      await Future.delayed(const Duration(milliseconds: 400));
      if (mounted) Navigator.pop(context);
    } catch (e, s) {
      logger.e('send team feedback failed', e, s);
      EasyLoading.showError(escapeDioException(e));
    }
  }
}
