import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../blocs/theme/theme_event.dart';
import '../widgets/animated_nav_button.dart';
import '../widgets/profile_header.dart';
import '../widgets/glassmorphic_container.dart';
import 'about_screen.dart';
import 'projects_screen.dart';
import 'skills_screen.dart';
import 'github_screen.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
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
                    ? [
                      const Color(0xFFF8FAFC),
                      const Color(0xFFE2E8F0),
                      const Color(0xFFCBD5E1),
                    ]
                    : [
                      const Color(0xFF0F172A),
                      const Color(0xFF1E293B),
                      const Color(0xFF334155),
                    ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Custom App Bar
              SliverAppBar(
                expandedHeight: 0,
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor.withValues(
                          alpha: 0.8,
                        ),
                      ),
                    ),
                  ),
                ),
                title: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.folder_special,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'PortfolioSync',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                actions: [
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: IconButton(
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          theme.brightness == Brightness.light
                              ? Icons.dark_mode_rounded
                              : Icons.light_mode_rounded,
                          key: ValueKey(theme.brightness),
                        ),
                      ),
                      onPressed: () {
                        context.read<ThemeBloc>().add(ToggleThemeEvent());
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

              // Main Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 48 : (isTablet ? 32 : 16),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      // Profile Header
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: ProfileHeader(
                            isTablet: isTablet,
                            isDesktop: isDesktop,
                          ),
                        ),
                      ),

                      const SizedBox(height: 60),

                      // Navigation Section
                      SlideTransition(
                        position: _slideAnimation,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: isDesktop ? 600 : double.infinity,
                          ),
                          child: GlassmorphicContainer(
                            child: Column(
                              children: [
                                AnimatedNavButton(
                                  title: 'About Me',
                                  subtitle: 'Learn more about my background',
                                  icon: Icons.person_rounded,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF059669),
                                      Color(0xFF10B981),
                                    ],
                                  ),
                                  onTap:
                                      () => _navigateWithAnimation(
                                        context,
                                        const AboutScreen(),
                                      ),
                                  delay: 100,
                                ),
                                const SizedBox(height: 16),
                                AnimatedNavButton(
                                  title: 'Featured Projects',
                                  subtitle: 'Explore my latest work',
                                  icon: Icons.work_rounded,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF2563EB),
                                      Color(0xFF3B82F6),
                                    ],
                                  ),
                                  onTap:
                                      () => _navigateWithAnimation(
                                        context,
                                        const ProjectsScreen(),
                                      ),
                                  delay: 200,
                                ),
                                const SizedBox(height: 16),
                                AnimatedNavButton(
                                  title: 'Technical Skills',
                                  subtitle: 'Technologies I work with',
                                  icon: Icons.code_rounded,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF7C3AED),
                                      Color(0xFF8B5CF6),
                                    ],
                                  ),
                                  onTap:
                                      () => _navigateWithAnimation(
                                        context,
                                        const SkillsScreen(),
                                      ),
                                  delay: 300,
                                ),
                                const SizedBox(height: 16),
                                AnimatedNavButton(
                                  title: 'GitHub Repositories',
                                  subtitle: 'Open source contributions',
                                  icon: Icons.code_off_rounded,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF0D9488),
                                      Color(0xFF14B8A6),
                                    ],
                                  ),
                                  onTap:
                                      () => _navigateWithAnimation(
                                        context,
                                        const GithubScreen(),
                                      ),
                                  delay: 400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateWithAnimation(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
