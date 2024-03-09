
class Spell {
  final String name;
  final int level;
  final String description;

  Spell(
    this.description,
    this.level,
    this.name,
  );

  Spell.fromJson(Map<String, dynamic> json)
    :name = json['name'] as String,
    level = json['level'] as int,
    description = json['desc'].toString();

  Map<String, dynamic> toJson() => {
    'name': name,
    'level': level,
    'desc': description,
  };
}