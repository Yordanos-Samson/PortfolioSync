import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../widgets/project_card.dart';

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
          'A comprehensive full-stack healthcare system featuring a React-based web dashboard and Flutter mobile app, powered by Supabase. Includes real-time appointment scheduling, video consultations, and role-based access for doctors, admins, and patients. Final year project focused on enhancing maternal healthcare access and coordination.',
      techStack:
          'Flutter, React, Supabase, PostgreSQL, JavaScript, Tailwind CSS, Realtime',
      // Note: Private repository due to group collaboration
    ),
    Project(
      title: 'Credential Verification App',
      description:
          'A Flutter-based credential wallet app developed during INSA internship. Scans QR codes to verify verifiable credentials with secure data handling. Integrated PostgreSQL and Dart Frog for API backend, utilizing qr_code_scanner package and JSON parsing.',
      techStack: 'Flutter, PostgreSQL, Dart Frog, QR Scanner, JSON',
      githubUrl:
          'https://github.com/Yordanos-Samson/credential-verification-app',
    ),
    Project(
      title: 'Mood-based Music Recommender',
      description:
          'An intelligent Android app that recommends music based on user mood using Google\'s Gemini API. Features mood detection, personalized recommendations, and smooth API integration for enhanced user experience.',
      techStack: 'Flutter, Google Gemini API, Android',
      githubUrl: 'https://github.com/Yordanos-Samson/mood-music-recommender',
    ),
    Project(
      title: 'C++ Management Systems Collection',
      description:
          'A comprehensive collection of management systems built with C++ including Car Rental Management, ECB Bank Management, Employee Management, and Student Records Management systems. Demonstrates object-oriented programming principles and system design.',
      techStack: 'C++, OOP, System Design, Data Structures',
      githubUrl: 'https://github.com/Yordanos-Samson/cpp-management-systems',
    ),
    Project(
      title: 'E-commerce Website',
      description:
          'A full-stack e-commerce platform built for practice using modern web technologies. Features product catalog, shopping cart, user authentication, and responsive design with clean UI/UX.',
      techStack: 'React, Vite, Node.js, JavaScript, CSS',
      githubUrl: 'https://github.com/Yordanos-Samson/ecommerce-website',
    ),
    Project(
      title: 'Python Console Quiz App',
      description:
          'An interactive console-based quiz application developed to enhance Python programming skills. Features multiple question types, scoring system, and user-friendly interface.',
      techStack: 'Python, Console Application, Data Handling',
      githubUrl: 'https://github.com/Yordanos-Samson/python-quiz-app',
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
                    'Featured Projects',
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
