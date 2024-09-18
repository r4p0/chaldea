import 'dart:convert';

import 'package:archive/archive.dart' show getCrc32;

import 'package:chaldea/app/api/atlas.dart';
import 'package:chaldea/models/gamedata/toplogin.dart';
import 'package:chaldea/models/models.dart';
import 'package:chaldea/models/userdata/version.dart';
import 'package:chaldea/packages/logger.dart';
import 'package:chaldea/utils/extension.dart';
import '../shared/agent.dart';
import 'network.dart';

class FakerAgentJP extends FakerAgent<FRequestJP, AutoLoginDataJP, NetworkManagerJP> {
  FakerAgentJP({required super.network});
  FakerAgentJP.s({
    required GameTop gameTop,
    required AutoLoginDataJP user,
  }) : super(network: NetworkManagerJP(gameTop: gameTop.copy(), user: user));

  @override
  Future<FResponse> gamedataTop({bool checkAppUpdate = true}) async {
    final tops = await AtlasApi.gametopsRaw(expireAfter: Duration.zero);
    if (tops != null) {
      network.gameTop.updateFrom(tops.jp);
    }
    final request = FRequestJP(network: network, path: '/gamedata/top');
    final fresp = await request.beginRequest();
    if (fresp.data.responses.any((e) => e.fail?['action'] == 'app_version_up')) {
      if (!checkAppUpdate) {
        throw Exception('fgo version updated');
      }
      final newVer = await AtlasApi.gPlayVer(network.gameTop.region);
      if (newVer == null) {
        throw Exception('fgo version updated but resolve new version failed');
      }
      if (AppVersion.parse(newVer) <= AppVersion.parse(network.gameTop.appVer)) {
        throw Exception('fgo version updated but no new version found');
      }
      network.gameTop.appVer = newVer;
      return gamedataTop(checkAppUpdate: false);
    }
    final resp = fresp.data.getResponse('gamedata');
    if (resp.isSuccess()) {
      int dataVer = resp.success!['dataVer']!;
      int dateVer = resp.success!['dateVer']!;
      String assetbundle = resp.success!['assetbundle'] ?? "";
      // String assetbundleKey = resp.success!['assetbundleKey']!;
      if (dataVer > network.gameTop.dataVer) network.gameTop.dataVer = dataVer;
      if (dateVer > network.gameTop.dateVer) network.gameTop.dateVer = dateVer;
      if (assetbundle.isNotEmpty) {
        final assetbundleData = network.catMouseGame.mouseInfoMsgpack(base64Decode(assetbundle));
        final String folderName = assetbundleData['folderName']!;
        network.gameTop.assetbundleFolder = folderName;
        // network.gameTop.assetbundle = assetbundle;
      }
      return fresp;
    } else {
      return fresp.throwError('gamedata');
    }
  }

  @override
  Future<FResponse> loginTop() async {
    final request = FRequestJP(network: network, path: '/login/top');
    request.addBaseField();
    if (network.gameTop.region == Region.jp) {
      await request.addSignatureField();
    }
    request.addFieldStr('deviceInfo', network.user.deviceInfo ?? FakerUA.deviceinfo);
    final int lastAccessTime = int.parse(request.paramString['lastAccessTime']!);
    final int userId = int.parse(network.user.auth!.userId);
    int userState = (-lastAccessTime >> 2) ^ userId & network.gameTop.folderCrc;
    request.addFieldInt64('userState', userState);
    request.addFieldStr('assetbundleFolder', network.gameTop.assetbundleFolder);
    request.addFieldInt32('isTerminalLogin', 1);
    if (network.gameTop.region == Region.na) {
      request.addFieldInt32('country', network.user.country.countryId);
    }
    final resp = await network.requestStart(request);
    resp.throwError('login');
    // topLogin = resp;
    final userGame = resp.data.mstData.user;
    if (userGame != null) {
      network.user.userGame = userGame;
    }
    return resp.throwError('login');
  }

  @override
  Future<FResponse> homeTop() async {
    final request = FRequestJP(network: network, path: '/home/top');
    return request.beginRequestAndCheckError('home');
  }

  @override
  Future<FResponse> followerList(
      {required int32_t questId, required int32_t questPhase, required bool isEnfoceRefresh}) async {
    final request = FRequestJP(network: network, path: '/follower/list');
    request.addFieldInt32('questId', questId);
    request.addFieldInt32('questPhase', questPhase);
    request.addFieldInt32('refresh', isEnfoceRefresh ? 1 : 0);
    return request.beginRequestAndCheckError('follower_list');
  }

  @override
  Future<FResponse> itemRecover({required int32_t recoverId, required int32_t num}) async {
    final request = FRequestJP(network: network, path: '/item/recover');
    request.addFieldInt32('recoverId', recoverId);
    request.addFieldInt32('num', num);
    final itemId = mstRecovers[recoverId]?.targetId;
    logger.t(
        'item/recover($recoverId): Item $itemId ${db.gameData.items[itemId]?.lName.l ?? "unknown recover id"} ×$num');
    return request.beginRequestAndCheckError('item_recover');
  }

  @override
  Future<FResponse> shopPurchase({required int32_t id, required int32_t num, int32_t anotherPayFlag = 0}) async {
    final request = FRequestJP(network: network, path: '/shop/purchase');
    request.addFieldInt32('id', id);
    request.addFieldInt32('num', num);
    if (anotherPayFlag > 0) {
      request.addFieldInt32('anotherPayFlag', anotherPayFlag);
    }
    return request.beginRequest();
  }

  @override
  Future<FResponse> shopPurchaseByStone({required int32_t id, required int32_t num}) async {
    final request = FRequestJP(network: network, path: '/shop/purchaseByStone');
    request.addFieldInt32('id', id);
    request.addFieldInt32('num', num);
    return request.beginRequest();
  }

  @override
  Future<FResponse> battleSetup({
    required int32_t questId,
    required int32_t questPhase,
    required int64_t activeDeckId,
    required int64_t followerId,
    required int32_t followerClassId,
    int32_t itemId = 0,
    int32_t boostId = 0,
    int32_t enemySelect = 0,
    int32_t questSelect = 0,
    int64_t userEquipId = 0,
    required int32_t followerType,
    List<int> routeSelect = const [],
    int32_t followerRandomLimitCount = 0, //?
    String choiceRandomLimitCounts = "{}",
    int32_t followerSpoilerProtectionLimitCount = 4, //?
    required int32_t followerSupportDeckId,
    int32_t campaignItemId = 0,
    int32_t restartWave = 0,
  }) async {
    final request = FRequestJP(network: network, path: '/battle/setup');
    request.addFieldInt32("questId", questId);
    request.addFieldInt32("questPhase", questPhase);
    request.addFieldInt64("activeDeckId", activeDeckId);
    request.addFieldInt64("followerId", followerId);
    request.addFieldInt32("followerClassId", followerClassId);
    request.addFieldInt32("itemId", itemId);
    request.addFieldInt32("boostId", boostId);
    request.addFieldInt32("enemySelect", enemySelect);
    request.addFieldInt32("questSelect", questSelect);
    request.addFieldInt64("userEquipId", userEquipId);
    request.addFieldInt32("followerType", followerType);
    request.addFieldStr("routeSelect", jsonEncode(routeSelect));
    request.addFieldStr("choiceRandomLimitCounts", choiceRandomLimitCounts);
    request.addFieldInt32("followerRandomLimitCount", followerRandomLimitCount);
    request.addFieldInt32("followerSpoilerProtectionLimitCount", followerSpoilerProtectionLimitCount);
    request.addFieldInt32("recommendSupportIdx", 0);
    request.addFieldInt32("followerSupportDeckId", followerSupportDeckId);
    request.addFieldInt32("campaignItemId", campaignItemId);
    request.addFieldInt32("restartWave", restartWave);
    final resp = await request.beginRequestAndCheckError('battle_setup');
    final battleEntity = resp.data.mstData.battles.firstOrNull;
    if (battleEntity != null) {
      lastBattle = curBattle ?? battleEntity;
      curBattle = battleEntity;
    }
    return resp;
  }

  @override
  Future<FResponse> battleResume({
    required int64_t battleId,
    required int32_t questId,
    required int32_t questPhase,
    required List<int32_t> usedTurnList,
  }) async {
    final request = FRequestJP(network: network, path: '/battle/resume');
    request.addFieldInt64("battleId", battleId);
    request.addFieldInt32("questId", questId);
    request.addFieldInt32("questPhase", questPhase);
    request.addFieldStr("routeSelect", jsonEncode(usedTurnList));
    final resp = await request.beginRequestAndCheckError('battle_resume');
    final battleEntity = resp.data.mstData.battles.firstOrNull;
    if (battleEntity != null) {
      lastBattle = curBattle ?? battleEntity;
      curBattle = battleEntity;
    }
    return resp;
  }

  @override
  Future<FResponse> battleResult({
    required int64_t battleId,
    required BattleResultType battleResult, // 0-none,1-win,2-lose,3-retire
    required BattleWinResultType winResult, // 1 or 1
    String scores = "",
    required BattleDataActionList action,
    List<List<int>> voicePlayedArray = const [], // [[svtId, x],...]
    List<int> aliveUniqueIds = const [], // add this if retire/fail
    List<BattleRaidResult> raidResult = const [],
    List<BattleSuperBossResult> superBossResult = const [],
    int32_t elapsedTurn = 1,
    required List<int32_t> usedTurnArray, // win 001, retire 100
    int32_t recordType = 1,
    Map<String, Object> recordJson = const {
      "turnMaxDamage": 0,
      "knockdownNum": 0,
      "totalDamageToAliveEnemy": 0,
    },
    List<Map<String, Object>> firstNpPlayList = const [],
    List<PlayerServantNoblePhantasmUsageDataEntity> playerServantNoblePhantasmUsageData =
        const [], // []/ [{"svtId":403500,"followerType":0,"seqId":403500,"addCount":3}]"
    // required  PlayerServantNoblePhantasmUsageData playerServantNoblePhantasmUsageData,
    Map<int, int> usedEquipSkillDict = const {},
    Map<int, int> svtCommonFlagDict = const {},
    List<int32_t> skillShiftUniqueIdArray = const [],
    List<int64_t> skillShiftNpcSvtIdArray = const [],
    List<int32_t> calledEnemyUniqueIdArray = const [],
    List<int32_t> routeSelectIdArray = const [],
    List<int32_t> dataLostUniqueIdArray = const [],
    List waveInfos = const [],
  }) async {
    final request = FRequestJP(network: network, path: '/battle/result');
    final _battleResult = battleResult.value, _winResult = winResult.value;

    Map<String, Object> dictionary = {
      "battleId": battleId,
      "battleResult": _battleResult,
      "winResult": _winResult,
      "scores": scores,
      "action": action.getSaveData(),
      "raidResult": jsonEncode(raidResult),
      "superBossResult": jsonEncode(superBossResult),
      "elapsedTurn": elapsedTurn,
      "recordType": recordType,
      "recordValueJson": recordJson,
      "tdPlayed": jsonEncode(firstNpPlayList),
      "useTreasureDevices": jsonEncode(playerServantNoblePhantasmUsageData.map((e) => e.getSaveData()).toList()),
      "usedEquipSkillList": usedEquipSkillDict,
      "svtCommonFlagList": svtCommonFlagDict,
      "skillShiftUniqueIds": skillShiftUniqueIdArray,
      "skillShiftNpcSvtIds": skillShiftNpcSvtIdArray,
      "calledEnemyUniqueIds": calledEnemyUniqueIdArray,
      "routeSelect": routeSelectIdArray,
      "dataLostUniqueIds": dataLostUniqueIdArray,
      "aliveUniqueIds": aliveUniqueIds,
      // "battleStatus": 1393373180,
      // "voicePlayedList": "[]",
      // "usedTurnList": [0, 0, 1]
    };

    int64_t num1 = 0;
    for (final result in raidResult) {
      num1 += result.getStatusLong();
    }
    int64_t num2 = 0;
    if (superBossResult.isNotEmpty) {
      throw ArgumentError.value(superBossResult, 'superBossResult', 'superBossResult is not supported');
    }
    for (final result in superBossResult) {
      num2 += result.getStatusLong();
    }
    int64_t num3 = 0;

    for (int num4 in aliveUniqueIds) {
      num3 += num4;
    }

    dictionary['battleStatus'] = getCrc32([
      ...BitConverter.getInt64(network.user.auth!.userIdInt + _battleResult),
      ...BitConverter.getInt64(num1 - 4231125),
      ...BitConverter.getInt64(num3 ~/ 2),
      ...BitConverter.getInt64(battleId - 2147483647),
      ...BitConverter.getInt64(num2 - 2469110),
    ]);
    dictionary['voicePlayedList'] = jsonEncode(voicePlayedArray);
    dictionary['usedTurnList'] = usedTurnArray;
    dictionary['waveInfo'] = "[]";
    logger.t('battle_result.result=${jsonEncode(dictionary)}');
    request.addFieldStr('result', network.catMouseGame.encryptBattleResult(dictionary));
    final resp = await request.beginRequestAndCheckError('battle_result');
    lastBattle = curBattle;
    curBattle = null;
    try {
      lastBattleResultData = BattleResultData.fromJson(resp.data.getResponse('battle_result').success!);
    } catch (e, s) {
      logger.e('parse battle result data failed', e, s);
    }
    network.mstData.battles.clear();
    return resp;
  }
}