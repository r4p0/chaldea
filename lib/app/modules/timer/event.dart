import 'package:chaldea/app/app.dart';
import 'package:chaldea/models/models.dart';
import 'package:chaldea/utils/utils.dart';
import 'package:chaldea/widgets/widgets.dart';
import 'base.dart';

class TimerEventTab extends StatelessWidget {
  final Region region;
  final List<Event> events;
  const TimerEventTab({super.key, required this.region, required this.events});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().timestamp;
    final events = this.events.toList();
    final groups = TimerEventItem.group(events, region);
    groups.sortByList((e) => [e.endedAt > now ? -1 : 1, (e.endedAt - now).abs()]);
    return ListView(
      children: [
        for (final group in groups) group.buildItem(context, expanded: true),
      ],
    );
  }
}

class TimerEventItem with TimerItem {
  final List<Event> events;
  final Region region;
  TimerEventItem(this.events, this.region);

  static List<TimerEventItem> group(List<Event> events, Region region) {
    Map<String, List<Event>> groups = {};
    events = events.toList();
    events.sort2((e) => e.endedAt);
    for (final event in events) {
      groups.putIfAbsent([event.startedAt, event.endedAt, event.finishedAt].join('-'), () => []).add(event);
    }
    return groups.values.map((e) => TimerEventItem(e, region)).toList();
  }

  @override
  int get endedAt => events.first.endedAt;

  @override
  Widget buildItem(BuildContext context, {bool expanded = false}) {
    final events = this.events.toList();
    events.sortByList((e) => [e.type == EventType.eventQuest ? -1 : 1, e.id]);
    final event = events.first;
    return SimpleAccordion(
      expanded: expanded,
      headerBuilder: (context, _) {
        Widget? subtitle;
        final now = DateTime.now().timestamp;
        if (event.startedAt > now) {
          // subtitle = Text("Start at ${event.startedAt.sec2date().toStringShort(omitSec: true)}");
        } else if (event.finishedAt > event.endedAt && event.finishedAt < event.endedAt + 35 * kSecsPerDay) {
          subtitle = Text("Shop closed at ${event.finishedAt.sec2date().toStringShort(omitSec: true)}");
        }
        return ListTile(
          dense: true,
          contentPadding: const EdgeInsetsDirectional.only(start: 16),
          leading: const Icon(Icons.flag, size: 24),
          minLeadingWidth: 28,
          title: Text.rich(TextSpan(children: [
            TextSpan(
              text: [
                fmtDate(event.startedAt),
                fmtDate(event.endedAt),
              ].join(" ~ "),
            )
          ])),
          subtitle: subtitle,
          trailing: CountDown(endedAt: event.endedAt.sec2date(), startedAt: event.startedAt.sec2date()),
          enabled: event.endedAt > now,
        );
      },
      contentBuilder: (context) {
        return Card(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: divideTiles(
                [
                  for (final event in events)
                    ListTile(
                      dense: true,
                      leading: () {
                        final jpEvent = db.gameData.events[event.id];
                        if (jpEvent == null) return null;
                        final banner = jpEvent.extra.allBanners.firstOrNull;
                        if (banner == null) return null;
                        return CachedImage(
                          imageUrl: banner,
                          aspectRatio: 8 / 3,
                          cachedOption: CachedImageOption(
                            placeholder: (context, url) => const SizedBox.shrink(),
                            errorWidget: (context, url, error) => const SizedBox.shrink(),
                          ),
                        );
                      }(),
                      title: Text(Transl.eventNames(event.name).l, maxLines: 2, overflow: TextOverflow.ellipsis),
                      onTap: () {
                        router.push(url: Routes.eventI(event.id), region: region);
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}