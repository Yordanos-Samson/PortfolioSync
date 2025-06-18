import 'package:flutter/material.dart';
import '../widgets/glassmorphic_container.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;

  final List<Map<String, dynamic>> experiences = [
    {
      'title': 'Information Network Security Agency (INSA)',
      'role': 'Flutter Developer Intern',
      'period': 'Jul 2024 - Oct 2024',
      'description':
          'Developed a Credential Verification App using Flutter, PostgreSQL, and Dart Frog. Implemented QR code scanning for secure credential verification with JSON parsing and API integration.',
      'achievements': [
        'Built secure credential wallet application',
        'Integrated PostgreSQL database with Dart Frog backend',
        'Implemented QR code scanning functionality',
        'Handled JSON parsing for credential data',
      ],
    },
  ];

  final List<Map<String, String>> education = [
    {
      'degree': 'Bachelor of Information Systems',
      'institution': 'University of Bahir Dar',
      'period': 'May 2022 - Jun 2025',
      'status': 'Final Year Student',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimations = List.generate(
      4, // Number of sections
      (index) =>
          Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(
                index * 0.2,
                0.5 + (index * 0.2),
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
                    'About Me',
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
                  delegate: SliverChildListDelegate([
                    // Summary Section
                    SlideTransition(
                      position: _slideAnimations[0],
                      child: FadeTransition(
                        opacity: _controller,
                        child: GlassmorphicContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_rounded,
                                    color: theme.primaryColor,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Professional Summary',
                                    style: theme.textTheme.headlineMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'A passionate Flutter developer from Ethiopia, dedicated to crafting efficient and high-quality mobile applications. With experience in building cross-platform apps using Flutter and Android Studio, I am committed to staying updated on the latest technologies to bring innovation and functionality to every project.',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'My path profile also includes projects in web development and programming languages such as Python and C++, showcasing my versatility and eagerness to learn. I have hands-on experience integrating backend technologies like PostgreSQL, Firebase, Supabase, and RESTful APIs, ensuring seamless user experiences across Android and iOS platforms.',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Experience Section
                    SlideTransition(
                      position: _slideAnimations[1],
                      child: FadeTransition(
                        opacity: _controller,
                        child: GlassmorphicContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.work_rounded,
                                    color: theme.primaryColor,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Work Experience',
                                    style: theme.textTheme.headlineMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              ...experiences.map(
                                (exp) => _buildExperienceCard(exp, theme),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Education Section
                    SlideTransition(
                      position: _slideAnimations[2],
                      child: FadeTransition(
                        opacity: _controller,
                        child: GlassmorphicContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.school_rounded,
                                    color: theme.primaryColor,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Education',
                                    style: theme.textTheme.headlineMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              ...education.map(
                                (edu) => _buildEducationCard(edu, theme),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Personal Qualities Section
                    SlideTransition(
                      position: _slideAnimations[3],
                      child: FadeTransition(
                        opacity: _controller,
                        child: GlassmorphicContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.psychology_rounded,
                                    color: theme.primaryColor,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Personal Qualities',
                                    style: theme.textTheme.headlineMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children:
                                    [
                                          'Punctual',
                                          'Goal-driven',
                                          'Highly Sociable',
                                          'Disciplined',
                                          'Problem-solver',
                                          'Adaptable',
                                          'Hard-working',
                                        ]
                                        .map(
                                          (quality) => Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: theme.primaryColor
                                                  .withOpacity(0.1),
                                              border: Border.all(
                                                color: theme.primaryColor
                                                    .withOpacity(0.3),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Text(
                                              quality,
                                              style: TextStyle(
                                                color: theme.primaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Icon(
                                    Icons.language_rounded,
                                    color: theme.primaryColor,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Languages: Fluent in English and Amharic',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> exp, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exp['title'],
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            exp['role'],
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            exp['period'],
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            exp['description'],
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
          ),
          const SizedBox(height: 12),
          ...exp['achievements']
              .map<Widget>(
                (achievement) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          achievement,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildEducationCard(Map<String, String> edu, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            edu['degree']!,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            edu['institution']!,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                edu['period']!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
