import 'package:flutter/material.dart';

import 'package:chaldea/app/app.dart';
import 'package:chaldea/app/descriptors/skill_descriptor.dart';
import 'package:chaldea/app/modules/common/builders.dart';
import 'package:chaldea/generated/l10n.dart';
import 'package:chaldea/models/models.dart';
import 'package:chaldea/utils/utils.dart';
import 'package:chaldea/widgets/widgets.dart';

class SupportServantPage extends StatefulWidget {
  final SupportServant svt;

  const SupportServantPage(this.svt, {Key? key}) : super(key: key);

  @override
  State<SupportServantPage> createState() => _SupportServantPageState();
}

class _SupportServantPageState extends State<SupportServantPage> {
  SupportServant get svt => widget.svt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.svtNames(svt.shownName).l),
      ),
      body: ListView(
        children: [
          baseInfoTable,
        ],
      ),
    );
  }

  Widget get baseInfoTable {
    return CustomTable(children: [
      CustomTableRow.fromTexts(texts: [svt.shownName], isHeader: true),
      TextButton(
        onPressed: () {
          if (svt.svt.collectionNo > 0) {
            router.push(url: Routes.servantI(svt.svt.collectionNo));
          } else {
            router.push(url: Routes.enemyI(svt.svt.id));
          }
        },
        style: kTextButtonDenseStyle,
        child: Text(svt.svt.collectionNo > 0
            ? 'Servant No.${svt.svt.collectionNo} - ${svt.svt.lName.l}'
            : 'Enemy No.${svt.svt.id} - ${svt.svt.lName.l}'),
      ),
      CustomTableRow(children: [
        TableCellData(
          child: svt.svt.iconBuilder(context: context, height: 64),
        ),
        TableCellData(
          flex: 3,
          padding: EdgeInsets.zero,
          child: CustomTable(
            hideOutline: true,
            children: [
              // CustomTableRow(children: [
              //   TableCellData(text: 'Lv', isHeader: true),
              //   TableCellData(text: svt.limit.limitCount.toString(), flex: 3),
              // ]),
              CustomTableRow.fromTextsWithHeader(
                texts: [
                  'Lv',
                  '${svt.lv}',
                  S.current.ascension_short,
                  svt.limit.limitCount.toString(),
                ],
                isHeaders: const [true, false, true, false],
              ),
              CustomTableRow.fromTextsWithHeader(
                texts: [
                  S.current.filter_sort_class,
                  Transl.svtClass(svt.svt.className).l,
                  S.current.filter_attribute,
                  Transl.svtAttribute(svt.svt.attribute).l,
                ],
                isHeaders: const [true, false, true, false],
                defaults: TableCellData(maxLines: 1),
              ),
              CustomTableRow.fromTextsWithHeader(
                texts: [
                  'HP',
                  svt.hp.format(compact: false),
                  'ATK',
                  svt.atk.format(compact: false)
                ],
                isHeaders: const [true, false, true, false],
              ),
            ],
          ),
        )
      ]),
      CustomTableRow.fromTexts(
        texts: [S.current.info_trait],
        isHeader: true,
      ),
      CustomTableRow.fromChildren(children: [
        SharedBuilder.traitList(context: context, traits: svt.traits)
      ]),
      if (svt.skills.skill1 != null ||
          svt.skills.skill2 != null ||
          svt.skills.skill3 != null)
        CustomTableRow.fromTexts(
          texts: [S.current.skill],
          isHeader: true,
        ),
      if (svt.skills.skill1 != null)
        SkillDescriptor(
          skill: svt.skills.skill1!,
          level: svt.skills.skillLv1,
          showEnemy: true,
          showPlayer: true,
        ),
      if (svt.skills.skill2 != null)
        SkillDescriptor(
          skill: svt.skills.skill2!,
          level: svt.skills.skillLv2,
          showEnemy: true,
          showPlayer: true,
        ),
      if (svt.skills.skill3 != null)
        SkillDescriptor(
          skill: svt.skills.skill3!,
          level: svt.skills.skillLv3,
          showEnemy: true,
          showPlayer: true,
        ),
      // if (enemy.classPassive.classPassive.isNotEmpty ||
      //     enemy.classPassive.addPassive.isNotEmpty)
      //   CustomTableRow.fromTexts(
      //     texts: [S.current.passive_skill],
      //     isHeader: true,
      //   ),
      // for (final skill in enemy.classPassive.classPassive)
      //   SkillDescriptor(
      //     skill: skill,
      //     showEnemy: true,
      //     showPlayer: true,
      //   ),
      // for (final skill in enemy.classPassive.addPassive)
      //   SkillDescriptor(
      //     skill: skill,
      //     showEnemy: true,
      //     showPlayer: true,
      //   ),
      CustomTableRow.fromTexts(
        texts: [S.current.noble_phantasm],
        isHeader: true,
      ),
      if (svt.noblePhantasm.noblePhantasm != null)
        TdDescriptor(
          td: svt.noblePhantasm.noblePhantasm!,
          level: svt.noblePhantasm.noblePhantasmLv,
          showEnemy: true,
          showPlayer: true,
        ),
      ...getCes(),
    ]);
  }

  List<Widget> getCes() {
    if (svt.equips.isEmpty) return [];
    List<Widget> children = [
      CustomTableRow.fromTexts(
        texts: [S.current.craft_essence],
        isHeader: true,
      ),
    ];
    for (final ce in svt.equips) {
      children.add(ListTile(
        leading: ce.equip.iconBuilder(context: context, width: 48),
        title: Text(ce.equip.lName.l),
        subtitle: Text(
            'Lv.${ce.lv} ${ce.limitCount == 4 ? S.current.ce_max_limit_break : ""}'),
      ));
      final skills = ce.equip.skills
          .where((skill) => skill.condLimitCount == ce.limitCount);
      children.addAll(skills.map((e) => SkillDescriptor(skill: e)));
    }

    return children;
  }
}