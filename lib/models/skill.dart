class Skill {
  final String name;
  final String iconPath; // Keep for backward compatibility

  Skill({required this.name, required this.iconPath});
}

// New skill data model for the improved approach
class SkillData {
  final String name;
  final dynamic icon; // Can be IconData or String
  final dynamic color; // Can be Color or String

  SkillData({required this.name, required this.icon, required this.color});
}
