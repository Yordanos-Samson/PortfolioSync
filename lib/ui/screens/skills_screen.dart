import 'package:flutter/material.dart';
import '../../models/skill.dart';
import '../widgets/skill_tile.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  static final List<Skill> skills = [
    Skill(
      name: 'Flutter',
      iconPath:
          'https://www.vectorlogo.zone/logos/flutterio/flutterio-icon.svg',
    ),
    Skill(
      name: 'Dart',
      iconPath: 'https://www.vectorlogo.zone/logos/dartlang/dartlang-icon.svg',
    ),
    Skill(
      name: 'C++',
      iconPath:
          'https://raw.githubusercontent.com/devicons/devicon/master/icons/cplusplus/cplusplus-original.svg',
    ),
    Skill(
      name: 'Python',
      iconPath:
          'https://raw.githubusercontent.com/devicons/devicon/master/icons/python/python-original.svg',
    ),
    Skill(
      name: 'JavaScript',
      iconPath:
          'https://raw.githubusercontent.com/devicons/devicon/master/icons/javascript/javascript-original.svg',
    ),
    Skill(
      name: 'React',
      iconPath:
          'https://raw.githubusercontent.com/devicons/devicon/master/icons/react/react-original.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Skills')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
        ),
        itemCount: skills.length,
        itemBuilder: (context, index) => SkillTile(skill: skills[index]),
      ),
    );
  }
}
