import 'package:flutter/material.dart';

import 'package:chaldea/generated/l10n.dart';
import 'package:chaldea/utils/utils.dart';
import '../../../models/models.dart';
import '../common/filter_group.dart';
import '../common/filter_page_base.dart';

class FfoPartFilterPage extends FilterPage<FfoPartFilterData> {
  const FfoPartFilterPage({
    Key? key,
    required FfoPartFilterData filterData,
    ValueChanged<FfoPartFilterData>? onChanged,
  }) : super(key: key, onChanged: onChanged, filterData: filterData);

  @override
  _FfoPartFilterPageState createState() => _FfoPartFilterPageState();
}

class _FfoPartFilterPageState extends FilterPageState<FfoPartFilterData> {
  @override
  Widget build(BuildContext context) {
    return buildAdaptive(
      title: Text(S.current.filter, textScaleFactor: 0.8),
      actions: getDefaultActions(onTapReset: () {
        filterData.reset();
        update();
      }),
      content: getListViewBody(children: [
        getGroup(header: S.of(context).filter_sort, children: [
          FilterGroup.display(
            useGrid: filterData.useGrid,
            onChanged: (v) {
              if (v != null) filterData.useGrid = v;
              update();
            },
          ),
        ]),
        //end

        getGroup(header: S.of(context).filter_sort, children: [
          for (int i = 0; i < filterData.sortKeys.length; i++)
            getSortButton<SvtCompare>(
              prefix: '${i + 1}',
              value: filterData.sortKeys[i],
              items: Map.fromIterables(FfoPartFilterData.kSortKeys, [
                S.current.filter_sort_number,
                S.current.filter_sort_class,
                S.current.filter_sort_rarity,
              ]),
              onSortAttr: (key) {
                filterData.sortKeys[i] = key ?? filterData.sortKeys[i];
                update();
              },
              reversed: filterData.sortReversed[i],
              onSortDirectional: (reversed) {
                filterData.sortReversed[i] = reversed;
                update();
              },
            ),
        ]),
        // buildClassFilter(filterData.classType),
        FilterGroup<SvtClass>(
          title: Text(S.current.filter_sort_class),
          options: const [
            ...SvtClassX.regular,
            SvtClass.shielder,
            SvtClass.ruler,
            SvtClass.avenger,
            SvtClass.moonCancer,
            SvtClass.alterEgo,
            SvtClass.foreigner
          ],
          values: filterData.classType,
          optionBuilder: (v) => Text(Transl.svtClass(v).l),
          onFilterChanged: (value, _) {
            update();
          },
        ),
        FilterGroup<int>(
          title: Text(S.current.rarity),
          options: const [1, 2, 3, 4, 5],
          values: filterData.rarity,
          optionBuilder: (v) => Text('$v$kStarChar'),
          onFilterChanged: (value, _) {
            update();
          },
        ),
      ]),
    );
  }
}