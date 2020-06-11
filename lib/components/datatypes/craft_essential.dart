part of datatypes;

enum CraftCompare { no, rarity, atk, hp }

@JsonSerializable(checked: true)
class CraftEssential {
  int no;
  String mcLink;
  String name;
  String nameJp;
  List<String> nameOther;
  int rarity;
  String icon;
  String illustration;
  List<String> illustrators;
  int cost;
  int hpMin;
  int hpMax;
  int atkMin;
  int atkMax;
  String skillIcon;
  String skill;
  String skillMax;
  List<String> eventIcons;
  List<String> eventSkills;
  String description;
  String descriptionJp;
  int category;
  String categoryText;
  List<String> characters;
  int bond;
  int valentine;

  CraftEssential({
    this.no,
    this.mcLink,
    this.name,
    this.nameJp,
    this.nameOther,
    this.rarity,
    this.icon,
    this.illustration,
    this.illustrators,
    this.cost,
    this.hpMin,
    this.hpMax,
    this.atkMin,
    this.atkMax,
    this.skillIcon,
    this.skill,
    this.skillMax,
    this.eventIcons,
    this.eventSkills,
    this.description,
    this.descriptionJp,
    this.category,
    this.categoryText,
    this.characters,
    this.bond,
    this.valentine,
  });

  static int compare(CraftEssential a, CraftEssential b,
      [List<CraftCompare> keys, List<bool> reversed]) {
    int res = 0;
    if (keys == null || keys.isEmpty) {
      keys = [CraftCompare.no];
    }
    for (var i = 0; i < keys.length; i++) {
      int r;
      switch (keys[i]) {
        case CraftCompare.no:
          r = a.no - b.no;
          break;
        case CraftCompare.rarity:
          r = a.rarity - b.rarity;
          break;
        case CraftCompare.atk:
          r = a.atkMax - b.atkMax;
          break;
        case CraftCompare.hp:
          r = a.hpMax - b.hpMax;
          break;
      }
      res = res * 1000 + ((reversed?.elementAt(i) ?? false) ? -r : r);
    }
    return res;
  }

  factory CraftEssential.fromJson(Map<String, dynamic> data) =>
      _$CraftEssentialFromJson(data);

  Map<String, dynamic> toJson() => _$CraftEssentialToJson(this);
}
