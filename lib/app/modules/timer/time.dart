import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:chaldea/models/models.dart';
import 'package:chaldea/packages/svg.dart';
import 'package:chaldea/utils/utils.dart';

class RegionTimeTab extends StatefulWidget {
  final Region region;
  RegionTimeTab({super.key, required this.region});

  @override
  State<RegionTimeTab> createState() => _RegionTimeTabState();
}

class _RegionTimeTabState extends State<RegionTimeTab> {
  Timer? _timer;
  DateTime t = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      t = DateTime.now();
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    List<_RegionData> list = [
      _RegionData(name: 'Device', tzName: t.timeZoneName, offset: t.timeZoneOffset, flagSvg: null, region: null),
    ];
    final regions = [widget.region, ...Region.values.where((e) => e != widget.region)];
    for (final region in regions) {
      list.addAll(getRegionData(region));
    }
    list.add(_RegionData(name: '', tzName: 'UTC', offset: Duration.zero, flagSvg: null, region: null));

    return ListView(children: [for (final data in list) buildItem(data)]);
  }

  List<_RegionData> getRegionData(Region region) {
    switch (region) {
      case Region.jp:
        return [
          _RegionData(
            name: region.localName,
            tzName: 'JST',
            offset: const Duration(hours: 9),
            flagSvg: SvgStrings.jpFlag,
            region: region,
          )
        ];
      case Region.cn:
        return [
          _RegionData(
            name: region.localName,
            tzName: 'CST',
            offset: const Duration(hours: 8),
            flagSvg: SvgStrings.cnFlag,
            region: region,
          )
        ];
      case Region.tw:
        return [
          _RegionData(
            name: region.localName,
            tzName: 'TST',
            offset: const Duration(hours: 8),
            flagSvg: SvgStrings.twFlag,
            region: region,
          )
        ];
      case Region.na:
        return [
          if (_showPST(t))
            _RegionData(
              name: region.localName,
              tzName: 'PST',
              offset: const Duration(hours: -9),
              flagSvg: SvgStrings.usFlag,
              region: region,
            ),
          if (_showPDT(t))
            _RegionData(
              name: region.localName,
              tzName: 'PDT',
              offset: const Duration(hours: -7),
              flagSvg: SvgStrings.usFlag,
              region: region,
            ),
        ];
      case Region.kr:
        return [
          _RegionData(
            name: region.localName,
            tzName: 'KST',
            offset: const Duration(hours: 9),
            flagSvg: SvgStrings.krFlag,
            region: region,
          )
        ];
    }
  }

  Widget buildItem(_RegionData data) {
    List<InlineSpan> subtitles = [
      TextSpan(text: [data.name, data.tzName].where((e) => e.isNotEmpty).join(' ')),
    ];
    if (data.offset != Duration.zero || data.tzName != 'UTC') {
      final h = data.offset.inHours, m = data.offset.inMinutes.abs() % Duration.minutesPerHour;
      subtitles.add(TextSpan(text: ' (UTC${h < 0 ? "-" : "+"}${h.abs()}${m == 0 ? "" : ":${_pad(m)}"})'));
    }
    final local = t.toUtc().add(data.offset);
    subtitles.add(TextSpan(text: '  ${_pad(local.month)}-${_pad(local.day)}'));
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: SizedBox(
          width: 40,
          child: Center(
            child: data.flagSvg == null ? null : SvgPicture.string(data.flagSvg!),
          ),
        ),
      ),
      title: Text(
        [local.hour, local.minute, local.second].map(_pad).join(':'),
        style: const TextStyle(
          fontFamily: kMonoFont,
          fontSize: 32,
        ),
      ),
      subtitle: Text.rich(TextSpan(children: subtitles)),
    );
  }

  String _pad(int v) => v.toString().padLeft(2, '0');
}

class _RegionData {
  String name;
  String tzName;
  Duration offset;
  String? flagSvg;
  Region? region;

  _RegionData({
    required this.name,
    required this.tzName,
    required this.offset,
    required this.flagSvg,
    required this.region,
  });
}

bool _showPDT(DateTime t) {
  // 夏令时间始于每年三  月的第二个星期日凌晨二时正，
  //      并终于每年十一月的第一个星期日凌晨二时正
  final pst = t.toUtc().add(const Duration(hours: -8));
  if (pst.month < 3 || pst.month > 11) return false;
  if (pst.month > 3 && pst.month < 11) return true;
  if (pst.month == 3) {
    // 最早的第二个星期日
    return pst.day >= 8;
  } else if (pst.month == 11) {
    // 最晚的第一个星期日
    return pst.day <= 7;
  } else {
    return false;
  }
}

bool _showPST(DateTime t) {
  final pst = t.toUtc().add(const Duration(hours: -8));
  if (pst.month < 3 || pst.month > 11) return true;
  if (pst.month > 3 && pst.month < 11) return false;
  if (pst.month == 3) {
    // 最晚的第二个星期日
    return pst.day <= 13;
  } else if (pst.month == 11) {
    // 最早的第一个星期日
    return pst.day >= 1;
  } else {
    return true;
  }
}
