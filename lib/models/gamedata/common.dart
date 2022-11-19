import 'package:chaldea/utils/atlas.dart';
import 'package:chaldea/utils/extension.dart';
import '../../app/app.dart';
import '../../app/tools/gamedata_loader.dart';
import '../../generated/l10n.dart';
import '../../packages/language.dart';
import '_helper.dart';
import 'event.dart';
import 'mappings.dart';

part '../../generated/models/gamedata/common.g.dart';
part 'common_helper.dart';

@JsonEnum(alwaysCreate: true)
enum Region {
  jp,
  cn,
  tw,
  na,
  kr,
}

const _regionLanguage = {
  Region.jp: Language.jp,
  Region.cn: Language.chs,
  Region.tw: Language.cht,
  Region.na: Language.en,
  Region.kr: Language.ko,
};

extension RegionX on Region {
  String get upper => name.toUpperCase();

  static Region? tryParse(String s) {
    return _$RegionEnumMap.entries
        .firstWhereOrNull((e) => e.value.toLowerCase() == s.toLowerCase())
        ?.key;
  }

  String get localName {
    switch (this) {
      case Region.jp:
        return S.current.region_jp;
      case Region.cn:
        return S.current.region_cn;
      case Region.tw:
        return S.current.region_tw;
      case Region.na:
        return S.current.region_na;
      case Region.kr:
        return S.current.region_kr;
    }
  }

  Language toLanguage() => _regionLanguage[this]!;
}

@JsonSerializable()
class NiceTrait with RouteInfo {
  static final Map<int, NiceTrait> _instances = {};

  final int id;
  final bool negative;

  Trait get name => kTraitIdMapping[id] ?? Trait.unknown;

  const NiceTrait._({required this.id, this.negative = false});

  factory NiceTrait({required int id, bool negative = false}) {
    negative = negative || id < 0;
    id = id.abs();
    return _instances.putIfAbsent(
        negative ? -id : id, () => NiceTrait._(id: id, negative: negative));
  }

  factory NiceTrait.signed(int sid) => _instances.putIfAbsent(
      sid, () => NiceTrait._(id: sid.abs(), negative: sid < 0));

  int get signedId => negative ? -id : id;

  factory NiceTrait.fromJson(Map<String, dynamic> json) =>
      _$NiceTraitFromJson(json);

  @override
  String toString() {
    return '$runtimeType($signedId)';
  }

  String shownName({bool addSvtId = true}) {
    final s = Transl.trait(id, addSvtId: addSvtId).l;
    if (negative == true) {
      return '${M.of(jp: null, cn: '非', tw: null, na: 'Not', kr: null)} $s';
    }
    return s;
  }

  static bool hasAllTraits(List<NiceTrait> traits, List<int> targets) {
    assert(targets.isNotEmpty);
    if (targets.isEmpty) return true;
    return targets
        .every((traitId) => traits.any((trait) => trait.id == traitId));
  }

  static bool hasAnyTrait(List<NiceTrait> traits, List<int> targets) {
    assert(targets.isNotEmpty);
    if (targets.isEmpty) return true;
    return targets.any((traitId) => traits.any((trait) => trait.id == traitId));
  }

  @override
  String get route => Routes.traitI(id);
}

@JsonSerializable()
class BgmRelease {
  int id;
  @JsonKey(unknownEnumValue: CondType.none)
  CondType type;
  int condGroup;
  List<int> targetIds;
  List<int> vals;
  int priority;
  String closedMessage;

  BgmRelease({
    required this.id,
    required this.type,
    required this.condGroup,
    required this.targetIds,
    required this.vals,
    required this.priority,
    required this.closedMessage,
  });

  factory BgmRelease.fromJson(Map<String, dynamic> json) =>
      _$BgmReleaseFromJson(json);
}

@JsonSerializable()
class BgmEntity extends Bgm {
  int priority;
  String detail;
  NiceShop? shop;
  String? logo;
  List<BgmRelease> releaseConditions;

  BgmEntity({
    required super.id,
    required super.name,
    required super.fileName,
    required super.notReleased,
    super.audioAsset,
    this.priority = 0,
    this.detail = "",
    this.shop,
    this.logo,
    this.releaseConditions = const [],
  });

  factory BgmEntity.fromJson(Map<String, dynamic> json) =>
      _$BgmEntityFromJson(json);
}

@JsonSerializable()
class Bgm with RouteInfo {
  int id;
  String name;
  String fileName;
  bool notReleased;
  String? audioAsset;

  Bgm({
    required this.id,
    this.name = '',
    required this.fileName,
    required this.notReleased,
    this.audioAsset,
  });

  Transl<String, String> get lName => Transl.bgmNames(name);

  String get tooltip => name.isEmpty ? fileName : lName.l;

  factory Bgm.fromJson(Map<String, dynamic> json) {
    final bgm =
        GameDataLoader.instance.tmp.gameJson?['bgms']?[json['id'].toString()];
    if (bgm != null) {
      json.addAll(Map.from(bgm));
    }
    return _$BgmFromJson(json);
  }

  @override
  String get route => Routes.bgmI(id);
}

enum CardType {
  none,
  arts,
  buster,
  quick,
  extra,
  blank,
  weak,
  strength,
}

enum SvtClass {
  saber,
  archer,
  lancer,
  rider,
  caster,
  assassin,
  berserker,
  shielder,
  ruler,
  alterEgo,
  avenger,
  demonGodPillar,
  moonCancer,
  foreigner,
  pretender,
  grandCaster,
  beastII,
  ushiChaosTide,
  beastI,
  beastIIIR,
  beastIIIL,
  beastIV,
  beastUnknown,
  unknown,
  agarthaPenth,
  cccFinaleEmiyaAlter,
  salemAbby,
  ALL, // ignore: constant_identifier_names
  EXTRA, // ignore: constant_identifier_names
  MIX, // ignore: constant_identifier_names
}

const kSvtClassShotName = {
  SvtClass.saber: '剣',
  SvtClass.archer: '弓',
  SvtClass.lancer: '槍',
  SvtClass.rider: '騎',
  SvtClass.caster: '術',
  SvtClass.assassin: '殺',
  SvtClass.berserker: '狂',
  SvtClass.avenger: '讐',
  SvtClass.ruler: '裁',
  SvtClass.moonCancer: '月',
  SvtClass.alterEgo: 'AE',
  SvtClass.foreigner: '降',
  SvtClass.shielder: '盾',
  SvtClass.demonGodPillar: '?',
  SvtClass.pretender: '偽',
  SvtClass.grandCaster: '術',
  SvtClass.beastII: '兽II',
  SvtClass.ushiChaosTide: '?',
  SvtClass.beastI: '獸I',
  SvtClass.beastIIIR: '獸IIIR',
  SvtClass.beastIIIL: '獸IIIL',
  SvtClass.beastIV: '獸IV',
  SvtClass.beastUnknown: '獸',
  SvtClass.unknown: '?',
  SvtClass.agarthaPenth: '?',
  SvtClass.cccFinaleEmiyaAlter: '?',
  SvtClass.salemAbby: '?',
};

const _kSvtClassRarityMap = {0: 0, 1: 1, 2: 1, 3: 2, 4: 3, 5: 3};

extension SvtClassX on SvtClass {
  int get id => kSvtClassIdsReverse[this]!;
  int get iconId => kSvtClassIconIds[this] ?? kUnknownClassIconId;

  String icon(int rarity) {
    rarity = _kSvtClassRarityMap[rarity] ?? rarity;
    return Atlas.asset('ClassIcons/class${rarity}_$iconId.png');
  }

  String get shortName => kSvtClassShotName[this] ?? '?';

  String get lName => Transl.svtClass(this).l;

  static List<SvtClass> regularAll = [
    ...regular,
    ...extra,
  ];

  static List<SvtClass> regularAllWithB2 = [
    ...regular,
    ...extra,
    SvtClass.beastII,
  ];

  static List<SvtClass> regularWithBeast = [
    ...regularAll,
    ...beasts,
  ];

  static const regular = <SvtClass>[
    SvtClass.saber,
    SvtClass.archer,
    SvtClass.lancer,
    SvtClass.rider,
    SvtClass.caster,
    SvtClass.assassin,
    SvtClass.berserker,
  ];
  static const extra = <SvtClass>[
    SvtClass.ruler,
    SvtClass.avenger,
    SvtClass.alterEgo,
    SvtClass.moonCancer,
    SvtClass.foreigner,
    SvtClass.pretender,
    SvtClass.shielder,
  ];
  static const beasts = <SvtClass>[
    SvtClass.beastI,
    SvtClass.beastII,
    SvtClass.beastIIIR,
    SvtClass.beastIIIL,
    SvtClass.beastIV,
    SvtClass.beastUnknown,
  ];
}

/// non-JP may not contains the last class
const kSvtIdsPlayable = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 23, 25, 28];
const kSvtIdsPlayableNA = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 23, 25];

const kSvtClassIds = {
  1: SvtClass.saber,
  2: SvtClass.archer,
  3: SvtClass.lancer,
  4: SvtClass.rider,
  5: SvtClass.caster,
  6: SvtClass.assassin,
  7: SvtClass.berserker,
  8: SvtClass.shielder,
  9: SvtClass.ruler,
  10: SvtClass.alterEgo,
  11: SvtClass.avenger,
  12: SvtClass.demonGodPillar,
// # 13
// # 14
// # 15
// # 16
  17: SvtClass.grandCaster,
// # 18
// # 19
  20: SvtClass.beastII,
  21: SvtClass.ushiChaosTide,
  22: SvtClass.beastI,
  23: SvtClass.moonCancer,
  24: SvtClass.beastIIIR,
  25: SvtClass.foreigner,
  26: SvtClass.beastIIIL,
  27: SvtClass.beastUnknown, //  # LB 5.2 beast
  28: SvtClass.pretender,
  29: SvtClass.beastIV,
  97: SvtClass.unknown,
// # 98
// # 99
// # 100
  107: SvtClass.agarthaPenth,
  124: SvtClass.cccFinaleEmiyaAlter,
  125: SvtClass.salemAbby,
// # 1000: SvtClass.OTHER,
// # For Support List
  1001: SvtClass.ALL,
  1002: SvtClass.EXTRA,
  1003: SvtClass.MIX,
};
final kSvtClassIdsReverse = kSvtClassIds.map((k, v) => MapEntry(v, k));

const kUnknownClassIconId = 12;
const kSvtClassIconIds = {
  SvtClass.saber: 1,
  SvtClass.archer: 2,
  SvtClass.lancer: 3,
  SvtClass.rider: 4,
  SvtClass.caster: 5,
  SvtClass.assassin: 6,
  SvtClass.berserker: 7,
  SvtClass.shielder: 8,
  SvtClass.ruler: 9,
  SvtClass.alterEgo: 10,
  SvtClass.avenger: 11,
  SvtClass.moonCancer: 23,
  SvtClass.foreigner: 25,
  SvtClass.grandCaster: 5,
  SvtClass.beastI: 21,
  SvtClass.beastII: 20,
  SvtClass.beastIIIL: 24,
  SvtClass.beastIIIR: 24,
  SvtClass.beastUnknown: 26,
  SvtClass.pretender: 28,
  SvtClass.beastIV: 29,
  SvtClass.cccFinaleEmiyaAlter: 124,
  SvtClass.ALL: 1001,
  SvtClass.EXTRA: 1002,
  SvtClass.unknown: 97,
};

enum SvtClassSupportGroupType {
  all,
  saber,
  archer,
  lancer,
  rider,
  caster,
  assassin,
  berserker,
  extra,
  mix,
  notSupport,
}

const kSvtClassSupportGroupIds = <int, SvtClassSupportGroupType>{
  0: SvtClassSupportGroupType.all,
  1: SvtClassSupportGroupType.saber,
  2: SvtClassSupportGroupType.archer,
  3: SvtClassSupportGroupType.lancer,
  4: SvtClassSupportGroupType.rider,
  5: SvtClassSupportGroupType.caster,
  6: SvtClassSupportGroupType.assassin,
  7: SvtClassSupportGroupType.berserker,
  8: SvtClassSupportGroupType.extra,
  9: SvtClassSupportGroupType.mix,
  999: SvtClassSupportGroupType.notSupport,
};
final kSvtClassSupportGroupIdsReverse =
    kSvtClassSupportGroupIds.map((k, v) => MapEntry(v, k));

/// Add new entry to common_helper [kTraitIdMapping]
enum Trait {
  unknown,
  genderMale,
  genderFemale,
  genderUnknown,
  classSaber,
  classLancer,
  classArcher,
  classRider,
  classCaster,
  classAssassin,
  classBerserker,
  classShielder,
  classRuler,
  classAlterEgo,
  classAvenger,
  classDemonGodPillar,
  classGrandCaster,
  classBeastI,
  classBeastII,
  classMoonCancer,
  classBeastIIIR,
  classForeigner,
  classBeastIIIL,
  classBeastUnknown,
  classPretender,
  attributeSky,
  attributeEarth,
  attributeHuman,
  attributeStar,
  attributeBeast,
  alignmentLawful,
  alignmentChaotic,
  alignmentNeutral,
  alignmentGood,
  alignmentEvil,
  alignmentBalanced,
  alignmentMadness,
  alignmentSummer,
  basedOnServant,
  human,
  undead,
  artificialDemon,
  demonBeast,
  demon,
  soldier,
  amazoness,
  skeleton,
  zombie,
  ghost,
  automata,
  golem,
  spellBook,
  homunculus,
  lamia,
  centaur,
  werebeast,
  chimera,
  wyvern,
  dragonType,
  demon2, // gazer,
  handOrDoor,
  demonGodPillar,
  oni,
  hand,
  door,
  threatToHumanity,
  divine,
  humanoid,
  dragon,
  dragonSlayer,
  roman,
  wildbeast,
  atalante,
  saberface,
  weakToEnumaElish,
  riding,
  arthur,
  skyOrEarthServant,
  brynhildsBeloved,
  undeadOrDemon,
  demonic,
  skyOrEarthExceptPseudoAndDemiServant,
  divineOrDemonOrUndead,
  saberClassServant,
  superGiant,
  king,
  greekMythologyMales,
  illya,
  feminineLookingServant,
  associatedToTheArgo,
  genderCaenisServant,
  hominidaeServant,
  blessedByKur,
  demonicBeastServant,
  canBeInBattle,
  notBasedOnServant,
  livingHuman,
  cardArts,
  cardBuster,
  cardQuick,
  cardExtra,
  buffPositiveEffect,
  buffNegativeEffect,
  buffIncreaseDamage,
  buffIncreaseDefence,
  buffDecreaseDamage,
  buffDecreaseDefence,
  buffMentalEffect,
  buffPoison,
  buffCharm,
  buffPetrify,
  buffStun,
  buffBurn,
  buffSpecialResistUp,
  buffSpecialResistDown,
  buffEvadeAndInvincible,
  buffSureHit,
  buffNpSeal,
  buffEvade,
  buffInvincible,
  buffTargetFocus,
  buffGuts,
  skillSeal,
  buffCurse,
  buffAtkUp,
  buffPowerModStrUp,
  buffDamagePlus,
  buffNpDamageUp,
  buffCritDamageUp,
  buffCritRateUp,
  buffAtkDown,
  buffPowerModStrDown,
  buffDamageMinus,
  buffNpDamageDown,
  buffCritDamageDown,
  buffCritRateDown,
  buffDeathResistDown,
  buffDefenceUp, // buffDefenceUp related
  buffMaxHpUpPercent,
  buffMaxHpDownPercent,
  buffMaxHpUp,
  buffMaxHpDown,
  buffImmobilize,
  buffIncreasePoisonEffectiveness,
  buffPigify,
  buffCurseEffectUp,
  buffTerrorStunChanceAfterTurn,
  buffConfusion,
  buffOffensiveMode,
  buffDefensiveMode,
  buffLockCardsDeck,
  buffDisableColorCard,
  buffChangeField,
  buffDefUp,
  buffInvinciblePierce,
  buffHpRecoveryPerTurn,
  buffNegativeEffectImmunity,
  buffDelayedNegativeEffect, // buffNegativeEffectAtTurnEnd
  attackPhysical,
  attackProjectile,
  attackMagical,
  criticalHit,
  faceCard,
  cardNP,
  kingproteaProliferation,
  kingproteaInfiniteProliferation,
  kingproteaProliferationNPDefense,
  fieldSunlight,
  fieldShore,
  fieldForest,
  fieldBurning,
  fieldCity,
  shadowServant,
  aoeNP,
  stNP,
  giant,
  childServant,
  buffSpecialInvincible,
  buffSkillRankUp,
  buffSleep,
  nobunaga,
  fieldImaginarySpace,
  existenceOutsideTheDomain,
  curse,
  fieldShoreOrImaginarySpace,
  shutenOnField,
  shuten,
  genji,
  vengeance,
  enemyGardenOfSinnersLivingCorpse,
  enemyGardenOfSinnersApartmentGhostAndSkeleton,
  enemyGardenOfSinnersBaseModel,
  enemyGardenOfSinnersVengefulSpiritOfSevenPeople,
  enemySaberEliWerebeastAndHomunculusAndKnight,
  enemySaberEliSkeletonAndGhostAndLamia,
  enemySaberEliBugAndGolem,
  enemySeraphEater,
  enemySeraphShapeshifter,
  enemySeraphTypeI,
  enemySeraphTypeSakura,
  enemyHimejiCastleKnightAndGazerAndMassProduction,
  enemyHimejiCastleDronesAndHomunculusAndAutomata,
  enemyHimejiCastleSkeletonAndScarecrow,
  enemyGuda3MiniNobu,
  enemyDavinciTrueEnemy,
  enemyDavinciFalseEnemy,
  enemyCaseFilesRareEnemy,
  enemyLasVegasBonusEnemy,
  enemySummerCampRareEnemy,
  enemyLittleBigTenguTsuwamonoEnemy,
  eventSaberWars,
  eventRashomon,
  eventOnigashima,
  eventOnigashimaRaid,
  eventPrisma,
  eventPrismaWorldEndMatch,
  eventNeroFest2,
  eventGuda2,
  eventNeroFest3,
  eventSetsubun,
  eventApocrypha,
  eventBattleInNewYork1,
  eventOniland,
  eventOoku,
  eventGuda4,
  eventLasVegas,
  eventBattleInNewYork2,
  eventSaberWarsII,
  eventSummerCamp,
  eventGuda5,
  cursedBook,
  buffCharmFemale,
  mechanical,
  fae,
  hasCostume,
  weakPointsRevealed,
  chenGongNpBlock,
  knightsOfTheRound,
  divineSpirit,
  buffNullifyBuff,
  enemyGudaMiniNobu,
  burningLove,
  buffStrongAgainstWildBeast,
  buffStrongAgainstDragon,
  fairyTaleServant,
  classBeastIV,
  havingAnimalsCharacteristics,
  like,
  exaltation,
  yuMeiren,
  milleniumCastle,
  protoMerlinNPChargeBlock,
  valkyrie,
  immuneToPigify,
  summerModeServant,
  shinsengumiServant,
  ryozanpaku,
}

enum CondType {
  none,
  questClear,
  itemGet,
  useItemEternity,
  useItemTime,
  useItemCount,
  svtLevel,
  svtLimit,
  svtGet,
  svtFriendship,
  svtGroup,
  event,
  date,
  weekday,
  purchaseQpShop,
  purchaseStoneShop,
  warClear,
  flag,
  svtCountStop,
  birthDay,
  eventEnd,
  svtEventJoin,
  missionConditionDetail,
  eventMissionClear,
  eventMissionAchieve,
  questClearNum,
  notQuestGroupClear,
  raidAlive,
  raidDead,
  raidDamage,
  questChallengeNum,
  masterMission,
  questGroupClear,
  superBossDamage,
  superBossDamageAll,
  purchaseShop,
  questNotClear,
  notShopPurchase,
  notSvtGet,
  notEventShopPurchase,
  svtHaving,
  notSvtHaving,
  questChallengeNumEqual,
  questChallengeNumBelow,
  questClearNumEqual,
  questClearNumBelow,
  questClearPhase,
  notQuestClearPhase,
  eventPointGroupWin,
  eventNormaPointClear,
  questAvailable,
  questGroupAvailableNum,
  eventNormaPointNotClear,
  notItemGet,
  costumeGet,
  questResetAvailable,
  svtGetBeforeEventEnd,
  questClearRaw,
  questGroupClearRaw,
  eventGroupPointRatioInTerm,
  eventGroupRankInTerm,
  notEventRaceQuestOrNotAllGroupGoal,
  eventGroupTotalWinEachPlayer,
  eventScriptPlay,
  svtCostumeReleased,
  questNotClearAnd,
  svtRecoverd,
  shopReleased,
  eventPoint,
  eventRewardDispCount,
  equipWithTargetCostume,
  raidGroupDead,
  notSvtGroup,
  notQuestResetAvailable,
  notQuestClearRaw,
  notQuestGroupClearRaw,
  notEventMissionClear,
  notEventMissionAchieve,
  notCostumeGet,
  notSvtCostumeReleased,
  notEventRaceQuestOrNotTargetRankGoal,
  playerGenderType,
  shopGroupLimitNum,
  eventGroupPoint,
  eventGroupPointBelow,
  eventTotalPoint,
  eventTotalPointBelow,
  eventValue,
  eventValueBelow,
  eventFlag,
  eventStatus,
  notEventStatus,
  forceFalse,
  svtHavingLimitMax,
  eventPointBelow,
  svtEquipFriendshipHaving,
  movieNotDownload,
  multipleDate,
  svtFriendshipAbove,
  svtFriendshipBelow,
  movieDownloaded,
  routeSelect,
  notRouteSelect,
  limitCount,
  limitCountAbove,
  limitCountBelow,
  badEndPlay,
  commandCodeGet,
  notCommandCodeGet,
  allUsersBoxGachaCount,
  totalTdLevel,
  totalTdLevelAbove,
  totalTdLevelBelow,
  commonRelease,
  battleResultWin,
  battleResultLose,
  eventValueEqual,
  boardGameTokenHaving,
  boardGameTokenGroupHaving,
  eventFlagOn,
  eventFlagOff,
  questStatusFlagOn,
  questStatusFlagOff,
  eventValueNotEqual,
  limitCountMaxEqual,
  limitCountMaxAbove,
  limitCountMaxBelow,
  boardGameTokenGetNum,
  battleLineWinAbove,
  battleLineLoseAbove,
  battleLineContinueWin,
  battleLineContinueLose,
  battleLineContinueWinBelow,
  battleLineContinueLoseBelow,
  battleGroupWinAvove,
  battleGroupLoseAvove,
  svtLimitClassNum,
  overTimeLimitRaidAlive,
  onTimeLimitRaidDead,
  onTimeLimitRaidDeadNum,
  raidBattleProgressAbove,
  svtEquipRarityLevelNum,
  latestMainScenarioWarClear,
  eventMapValueContains,
  resetBirthDay,
  shopFlagOn,
  shopFlagOff,
  purchaseValidShopGroup,
  svtLevelClassNum,
  svtLevelIdNum,
  limitCountImageEqual,
  limitCountImageAbove,
  limitCountImageBelow,
  eventTypeStartTimeToEndDate,
  existBoxGachaScriptReplaceGiftId,
  notExistBoxGachaScriptReplaceGiftId,
  limitedPeriodVoiceChangeTypeOn,
  startRandomMission,
  randomMissionClearNum,
  progressValueEqual,
  progressValueAbove,
  progressValueBelow,
  randomMissionTotalClearNum,
  weekdays,
  eventFortificationRewardNum,
  questClearBeforeEventStart,
  notQuestClearBeforeEventStart,
  eventTutorialFlagOn,
  eventTutorialFlagOff,
}
