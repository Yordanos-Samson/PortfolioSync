import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../widgets/project_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  static final List<Project> projects = [
    Project(
      title: 'CareSync Healthcare Platform',
      description:
          'A full-stack healthcare system with a React-based web dashboard and Flutter mobile app, featuring real-time appointment scheduling and video consultations.',
      techStack: 'Flutter, React, Supabase, JavaScript',
    ),
    Project(
      title: 'Credential Verification App',
      description:
          'A Flutter app for scanning QR codes to verify credentials, developed during INSA internship.',
      techStack: 'Flutter, PostgreSQL, Dart Frog',
      githubUrl:
          'https://github.com/yordanos-samson/credential-verification-app',
    ),
    Project(
      title: 'Mood-based Music Recommender',
      description:
          'An Android app that suggests music based on user mood using Google’s Gemini API.',
      techStack: 'Flutter, Gemini API',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Projects')),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) => ProjectCard(project: projects[index]),
      ),
    );
  }
}
