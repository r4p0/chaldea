import 'package:chaldea/generated/l10n.dart';
import 'package:chaldea/utils/extension.dart';
import '_helper.dart';
import 'common.dart';
import 'item.dart';

part '../../generated/models/gamedata/gacha.g.dart';

@JsonSerializable(createToJson: false)
class MstGacha {
  int id; //  50001251,
  String name; //  "【ニューイヤー1延長】【課金】第1部 0章 クリア前ベース",
  int imageId; //  80126,
  int priority; //  20122,
  int warId; //  100,
  int gachaSlot; //  3,
  int type; //  1,
  int shopId1; //  4,
  int shopId2; //  5,
  int rarityId; //  3,
  int baseId; //  3,
  int adjustId; //  50000731,
  int pickupId; //  50000772,
  int ticketItemId; //  4001,
  int gachaGroupId; //  0,
  int drawNum1; //  1,
  int drawNum2; //  10,
  int extraGroupId1; //  0,
  int extraGroupId2; //  0,
  int extraAddCount1; //  0,
  int extraAddCount2; //  0,
  int freeDrawFlag; //  0,
  int maxDrawNum; //  0,
  int beforeGachaId; //  101,
  int beforeDrawNum; //  1,
  int openedAt; //  1484114400,
  int closedAt; //  1484233199,
  int condQuestId; //  1000002,
  int condQuestPhase; //  1,
  String detailUrl; //  "/summon/gacha-description_newyear2017_12_tbyx2kua6c33y.html",
  int bannerQuestId; //  1000002,
  int bannerQuestPhase; //  1,
  int flag; //  0
  bool userAdded;

  MstGacha({
    this.id = 0,
    this.name = "",
    this.imageId = 0,
    this.priority = 0,
    this.warId = 0,
    this.gachaSlot = 0,
    this.type = 1,
    this.shopId1 = 0,
    this.shopId2 = 0,
    this.rarityId = 0,
    this.baseId = 0,
    this.adjustId = 0,
    this.pickupId = 0,
    this.ticketItemId = 0,
    this.gachaGroupId = 0,
    this.drawNum1 = 0,
    this.drawNum2 = 0,
    this.extraGroupId1 = 0,
    this.extraGroupId2 = 0,
    this.extraAddCount1 = 0,
    this.extraAddCount2 = 0,
    this.freeDrawFlag = 0,
    this.maxDrawNum = 0,
    this.beforeGachaId = 0,
    this.beforeDrawNum = 0,
    this.openedAt = 0,
    this.closedAt = 0,
    this.condQuestId = 0,
    this.condQuestPhase = 0,
    this.detailUrl = "",
    this.bannerQuestId = 0,
    this.bannerQuestPhase = 0,
    this.flag = 0,
    this.userAdded = false,
  });

  factory MstGacha.fromJson(Map<String, dynamic> json) => _$MstGachaFromJson(json);

  GachaType get gachaType => GachaType.values.firstWhereOrNull((e) => e.id == type) ?? GachaType.unknown;

  bool get isLuckyBag => type == GachaType.chargeStone.id;

  String? getHtmlUrl(Region region) {
    // final page = gacha?.detailUrl;
    // if (page == null || page.trim().isEmpty) return null;
    if (const [1, 101].contains(id)) return null;
    switch (region) {
      case Region.jp:
        // return 'https://webview.fate-go.jp/webview$page';
        if (openedAt < 1640790000) {
          // ID50017991 2021-12-29 23:00+08
          return null;
        }
        return "https://static.atlasacademy.io/file/aa-fgo/GameData-uTvNN4iBTNInrYDa/JP/Banners/$id/index.html";
      case Region.na:
        if (openedAt < 1641268800) {
          // 50010611: 2022-01-04 12:00+08
          return null;
        }
        return "https://static.atlasacademy.io/file/aa-fgo/GameData-uTvNN4iBTNInrYDa/NA/Banners/$id/index.html";
      case Region.cn:
      case Region.tw:
      case Region.kr:
        return null;
    }
  }
}

@JsonSerializable(createToJson: false)
class NiceGacha {
  int id;
  String name;
  int imageId;
  @GachaTypeConverter()
  GachaType type;
  int adjustId;
  int pickupId;
  int drawNum1;
  int drawNum2;
  int maxDrawNum;
  int openedAt;
  int closedAt;
  String detailUrl;
  @JsonKey(unknownEnumValue: GachaFlag.none)
  List<GachaFlag> flags;
  List<GachaStoryAdjust> storyAdjusts;

  bool userAdded;

  NiceGacha({
    this.id = 0,
    this.name = '',
    this.imageId = 0,
    this.type = GachaType.payGacha,
    this.adjustId = 0,
    this.pickupId = 0,
    this.drawNum1 = 0,
    this.drawNum2 = 0,
    this.maxDrawNum = 0,
    this.openedAt = 0,
    this.closedAt = 0,
    this.detailUrl = '',
    this.flags = const [],
    this.storyAdjusts = const [],
    this.userAdded = false,
  });
  factory NiceGacha.fromJson(Map<String, dynamic> json) => _$NiceGachaFromJson(json);

  bool get isLuckyBag => type == GachaType.chargeStone;

  String? getHtmlUrl(Region region) {
    // final page = gacha?.detailUrl;
    // if (page == null || page.trim().isEmpty) return null;
    if (const [1, 101].contains(id)) return null;
    switch (region) {
      case Region.jp:
        // return 'https://webview.fate-go.jp/webview$page';
        if (openedAt < 1640790000) {
          // ID50017991 2021-12-29 23:00+08
          return null;
        }
        return "https://static.atlasacademy.io/file/aa-fgo/GameData-uTvNN4iBTNInrYDa/JP/Banners/$id/index.html";
      case Region.na:
        if (openedAt < 1641268800) {
          // 50010611: 2022-01-04 12:00+08
          return null;
        }
        return "https://static.atlasacademy.io/file/aa-fgo/GameData-uTvNN4iBTNInrYDa/NA/Banners/$id/index.html";
      case Region.cn:
      case Region.tw:
      case Region.kr:
        return null;
    }
  }
}

@JsonSerializable(createToJson: false)
class GachaStoryAdjust {
  int adjustId;
  int idx;
  @CondTypeConverter()
  CondType condType;
  int targetId;
  int value;
  int imageId;

  GachaStoryAdjust({
    required this.adjustId,
    this.idx = 1,
    this.condType = CondType.none,
    this.targetId = 0,
    this.value = 0,
    this.imageId = 0,
  });

  factory GachaStoryAdjust.fromJson(Map<String, dynamic> json) => _$GachaStoryAdjustFromJson(json);
}

class GachaTypeConverter extends JsonConverter<GachaType, dynamic> {
  const GachaTypeConverter();

  static const payTypeToGachaType = <String, GachaType>{
    "stone": GachaType.payGacha,
    "friendPoint": GachaType.freeGacha,
    "ticket": GachaType.ticketGacha,
    "chargeStone": GachaType.chargeStone,
  };

  @override
  GachaType fromJson(dynamic value) {
    if (value == null) return GachaType.payGacha;
    if (value is int) return GachaType.values.firstWhere((e) => e.id == value, orElse: () => GachaType.unknown);
    return payTypeToGachaType[value] ?? decodeEnum(_$GachaTypeEnumMap, value, GachaType.unknown);
  }

  @override
  String toJson(GachaType obj) => _$GachaTypeEnumMap[obj] ?? obj.name;
}

// public enum SummonControl.GACHATYPE or PayType
@JsonEnum(alwaysCreate: true)
enum GachaType {
  unknown(0),
  payGacha(1),
  freeGacha(3),
  ticketGacha(5),
  chargeStone(7),
  ;

  const GachaType(this.id);
  final int id;

  String get shownName {
    switch (this) {
      case unknown:
        return S.current.unknown;
      case freeGacha:
        return Items.friendPoint?.lName.l ?? 'FriendPoint';
      case chargeStone:
        return S.current.lucky_bag;
      case payGacha:
        return S.current.normal;
      case ticketGacha:
        return name;
    }
  }
}

enum GachaFlag {
  none,
  pcMessage, // 2
  bonusSelect, // 8
}