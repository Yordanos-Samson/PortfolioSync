import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(project.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.description),
            Text('Tech: ${project.techStack}'),
            if (project.githubUrl != null)
              TextButton(
                onPressed: () async {
                  final url = Uri.parse(project.githubUrl!);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                child: const Text('View on GitHub'),
              ),
          ],
        ),
      ),
    );
  }
}