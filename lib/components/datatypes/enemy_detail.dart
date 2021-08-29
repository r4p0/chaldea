part of datatypes;

@JsonSerializable(checked: true)
class EnemyDetail {
  String category;
  String? icon;
  List<String> ids;
  List<String> names;
  List<String> classIcons;
  String attribute;
  List<String> traits;
  int? actions;
  List<int> charges;
  String? deathRate;
  String noblePhantasm;
  String skill;
  List<int> hitsCommon;
  List<int> hitsCritical;
  List<int> hitsNp;
  String firstStage;

  EnemyDetail({
    required this.category,
    required this.icon,
    required this.ids,
    required this.names,
    required this.classIcons,
    required this.attribute,
    required this.traits,
    required this.actions,
    required this.charges,
    required this.deathRate,
    required this.noblePhantasm,
    required this.skill,
    required this.hitsCommon,
    required this.hitsCritical,
    required this.hitsNp,
    required this.firstStage,
  });

  List<String> get lNames => names.map((e) => Localized.enemy.of(e)).toList();

  List<String> get lIds => ids.map((e) => lNameOf(e)).toList();

  static String lNameOf(String name) {
    if (name.contains(' ')) {
      return name
          .split(' ')
          .map((e) =>
              e.length == 1 ? _localizeClassName(e) : Localized.enemy.of(e))
          .join(' ');
    } else {
      return Localized.enemy.of(name);
    }
  }

  static String _localizeClassName(String? clsName) {
    if (clsName == null) return '';
    if (Language.isCN)
      return clsName;
    else if (Language.isJP)
      return {
            '剑': '剣',
            '弓': '弓',
            '枪': '槍',
            '骑': '騎',
            '术': '術',
            '杀': '殺',
            '狂': '狂',
            '仇': '讐',
            '裁': '裁',
            '月': '月',
            '他': '分',
            '降': '降',
          }[clsName] ??
          clsName;
    else {
      return {
            '剑': 'Saber',
            '弓': 'Archer',
            '枪': 'Lancer',
            '骑': 'Rider',
            '术': 'Caster',
            '杀': 'Assassin',
            '狂': 'Berserker',
            '仇': 'Avenger',
            '裁': 'Ruler',
            '月': 'MoonCancer',
            '他': 'Alterego',
            '降': 'Foreigner',
          }[clsName] ??
          clsName;
    }
  }

  factory EnemyDetail.fromJson(Map<String, dynamic> data) =>
      _$EnemyDetailFromJson(data);

  Map<String, dynamic> toJson() => _$EnemyDetailToJson(this);
}
