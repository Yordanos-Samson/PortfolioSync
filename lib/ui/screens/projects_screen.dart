import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../widgets/project_card.dart';
import '../widgets/glassmorphic_container.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;

  static final List<Project> projects = [
    Project(
      title: 'CareSync Healthcare Platform',
      description:
          'A comprehensive healthcare system with React-based web dashboard and Flutter mobile app, featuring real-time appointment scheduling, video consultations, and patient management.',
      techStack: 'Flutter, React, Supabase, JavaScript, WebSocket, Node.js',
      githubUrl: 'https://github.com/yordanos-samson/caresync',
    ),
    Project(
      title: 'Credential Verification App',
      description:
          'A Flutter app for scanning QR codes to verify credentials, developed during INSA internship with advanced security features.',
      techStack: 'Flutter, PostgreSQL, Dart Frog, QR Scanner',
      githubUrl:
          'https://github.com/yordanos-samson/credential-verification-app',
    ),
    Project(
      title: 'Mood-based Music Recommender',
      description:
          'An intelligent Android app that suggests music based on user mood using Google\'s Gemini API with machine learning capabilities.',
      techStack: 'Flutter, Gemini API, Node.js, Machine Learning',
      githubUrl: 'https://github.com/yordanos-samson/mood-music',
    ),
    Project(
      title: 'Chapa Payment Integration',
      description:
          'A comprehensive payment solution for Ethiopian businesses with Chapa payment gateway integration and transaction management.',
      techStack: 'Flutter, Chapa API, Node.js, PostgreSQL',
      githubUrl: 'https://github.com/yordanos-samson/chapa-flutter',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimations = List.generate(
      projects.length,
      (index) =>
          Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(
                index * 0.1,
                0.5 + (index * 0.1),
                curve: Curves.easeOutCubic,
              ),
            ),
          ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isDesktop = size.width > 1200;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                theme.brightness == Brightness.light
                    ? [const Color(0xFFF8FAFC), const Color(0xFFE2E8F0)]
                    : [const Color(0xFF0F172A), const Color(0xFF1E293B)],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                floating: true,
                pinned: true,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'My Projects',
                    style: TextStyle(
                      color: theme.textTheme.headlineMedium?.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(isDesktop ? 32 : (isTablet ? 24 : 16)),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return SlideTransition(
                      position: _slideAnimations[index],
                      child: FadeTransition(
                        opacity: _controller,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ProjectCard(
                            project: projects[index],
                            delay: index * 100,
                          ),
                        ),
                      ),
                    );
                  }, childCount: projects.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
