import 'package:flutter/material.dart';
import '../../models/skill.dart';

class SkillTile extends StatelessWidget {
  final Skill skill;
  const SkillTile({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(skill.iconPath, width: 50, height: 50),
          const SizedBox(height: 8),
          Text(skill.name, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}