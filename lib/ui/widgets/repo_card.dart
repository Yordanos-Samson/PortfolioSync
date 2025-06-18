import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/github_repo.dart';

class RepoCard extends StatelessWidget {
  final GithubRepo repo;
  const RepoCard({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          repo.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(repo.description),
            Text('Stars: ${repo.stars}'),
            TextButton(
              onPressed: () async {
                final url = Uri.parse(repo.url);
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
