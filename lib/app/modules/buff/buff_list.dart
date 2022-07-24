import 'package:flutter/material.dart';

import 'package:chaldea/app/app.dart';
import 'package:chaldea/generated/l10n.dart';
import 'package:chaldea/models/models.dart';
import 'package:chaldea/utils/utils.dart';
import 'package:chaldea/widgets/widgets.dart';
import '../common/filter_page_base.dart';
import 'filter.dart';

class BuffListPage extends StatefulWidget {
  final BuffType? type;
  const BuffListPage({Key? key, this.type}) : super(key: key);

  @override
  _BuffListPageState createState() => _BuffListPageState();
}

class _BuffListPageState extends State<BuffListPage>
    with SearchableListState<Buff?, BuffListPage> {
  final filterData = BuffFilterData();
  int? get _searchBuffId {
    final _id = int.tryParse(searchEditingController.text);
    if (_id != null && _id >= 0 && !db.gameData.baseBuffs.containsKey(_id)) {
      return _id;
    }
    return null;
  }

  @override
  Iterable<Buff?> get wholeData {
    int? _id = _searchBuffId;
    return [
      if (_id != null) null,
      ...db.gameData.baseBuffs.values,
    ];
  }

  @override
  bool get prototypeExtent => true;

  @override
  void initState() {
    super.initState();
    if (widget.type != null) {
      filterData.buffType.options = {widget.type!};
    }
  }

  @override
  Widget build(BuildContext context) {
    filterShownList(compare: (a, b) => (a?.id ?? 0) - (b?.id ?? 0));
    return scrollListener(
      useGrid: false,
      appBar: AppBar(
        title: const Text("Buffs"),
        bottom: searchBar,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            tooltip: S.current.filter,
            onPressed: () => FilterPage.show(
              context: context,
              builder: (context) => BuffFilter(
                filterData: filterData,
                onChanged: (_) {
                  if (mounted) setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool filter(Buff? buff) {
    if (buff == null) return true;
    if (!filterData.stackable.matchOne(buff.buffGroup == 0)) {
      return false;
    }
    if (!filterData.buffType.matchOne(buff.type)) {
      return false;
    }
    if (!filterData.trait.matchAny([
      ...buff.vals,
      ...buff.ckSelfIndv,
      ...buff.ckOpIndv,
      if (buff.script?.INDIVIDUALITIE != null) buff.script!.INDIVIDUALITIE!,
      if (buff.script?.UpBuffRateBuffIndiv != null)
        ...buff.script!.UpBuffRateBuffIndiv!,
    ].map((e) => e.id))) {
      return false;
    }

    return true;
  }

  @override
  Iterable<String?> getSummary(Buff? buff) sync* {
    if (buff == null) {
      yield _searchBuffId?.toString();
      return;
    }
    yield buff.id.toString();
    yield buff.type.toString();
    yield* SearchUtil.getAllKeys(Transl.buffType(buff.type));
    yield* SearchUtil.getAllKeys(buff.lName);
    yield* SearchUtil.getAllKeys(buff.lDetail);
  }

  @override
  Widget listItemBuilder(Buff? buff) {
    return ListTile(
      dense: true,
      leading: buff?.icon == null
          ? const SizedBox(height: 24, width: 24)
          : db.getIconImage(buff?.icon, height: 24),
      horizontalTitleGap: 8,
      title: Text(buff?.lName.l ?? "Buff $_searchBuffId"),
      subtitle: buff == null
          ? null
          : Text(
              '${buff.id} ${buff.type.name} ${Transl.buffType(buff.type).l}'),
      onTap: () {
        final id = buff?.id ?? _searchBuffId;
        if (id != null) router.push(url: Routes.buffI(id));
      },
    );
  }

  @override
  Widget gridItemBuilder(Buff? buff) =>
      throw UnimplementedError('GridView not designed');
}
