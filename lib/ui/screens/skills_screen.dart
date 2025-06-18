import 'package:flutter/material.dart';
import '../../models/skill.dart';
import '../widgets/glassmorphic_container.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;

  // Using a different approach with IconData and colors for better Flutter compatibility
  static final Map<String, List<Map<String, dynamic>>> skillCategories = {
    'Programming Languages': [
      {'name': 'Dart', 'icon': Icons.code, 'color': const Color(0xFF0175C2)},
      {'name': 'C++', 'icon': Icons.memory, 'color': const Color(0xFF00599C)},
      {
        'name': 'C#',
        'icon': Icons.developer_mode,
        'color': const Color(0xFF239120),
      },
      {
        'name': 'Python',
        'icon': Icons.psychology,
        'color': const Color(0xFF3776AB),
      },
      {
        'name': 'JavaScript',
        'icon': Icons.javascript,
        'color': const Color(0xFFF7DF1E),
      },
    ],
    'Mobile Development': [
      {
        'name': 'Flutter',
        'icon': Icons.flutter_dash,
        'color': const Color(0xFF02569B),
      },
      {
        'name': 'Android Studio',
        'icon': Icons.android,
        'color': const Color(0xFF3DDC84),
      },
    ],
    'Web Development': [
      {'name': 'HTML5', 'icon': Icons.web, 'color': const Color(0xFFE34F26)},
      {'name': 'CSS3', 'icon': Icons.style, 'color': const Color(0xFF1572B6)},
      {
        'name': 'React',
        'icon': Icons.web_asset,
        'color': const Color(0xFF61DAFB),
      },
      {'name': 'Vite', 'icon': Icons.bolt, 'color': const Color(0xFF646CFF)},
      {'name': 'Node.js', 'icon': Icons.dns, 'color': const Color(0xFF339933)},
    ],
    'Backend & Databases': [
      {
        'name': 'PostgreSQL',
        'icon': Icons.storage,
        'color': const Color(0xFF336791),
      },
      {
        'name': 'Microsoft SQL Server',
        'icon': Icons.storage_outlined,
        'color': const Color(0xFFCC2927),
      },
      {
        'name': 'Firebase',
        'icon': Icons.local_fire_department,
        'color': const Color(0xFFFFCA28),
      },
      {
        'name': 'Supabase',
        'icon': Icons.cloud_outlined,
        'color': const Color(0xFF3ECF8E),
      },
      {
        'name': 'Dart Frog',
        'icon': Icons.api,
        'color': const Color(0xFF02569B),
      },
    ],
    'Tools & Technologies': [
      {'name': 'Git', 'icon': Icons.source, 'color': const Color(0xFFF05032)},
      {
        'name': 'Linux',
        'icon': Icons.computer,
        'color': const Color(0xFFFCC624),
      },
      {
        'name': 'REST APIs',
        'icon': Icons.api_outlined,
        'color': const Color(0xFF009688),
      },
      {
        'name': 'JSON',
        'icon': Icons.data_object,
        'color': const Color(0xFF000000),
      },
    ],
    'Specialized Skills': [
      {
        'name': 'QR Code Scanning',
        'icon': Icons.qr_code_scanner,
        'color': const Color(0xFF4CAF50),
      },
      {
        'name': 'Google Gemini API',
        'icon': Icons.auto_awesome,
        'color': const Color(0xFF4285F4),
      },
      {
        'name': 'System Analysis',
        'icon': Icons.analytics,
        'color': const Color(0xFF9C27B0),
      },
      {
        'name': 'Data Structures',
        'icon': Icons.account_tree,
        'color': const Color(0xFF795548),
      },
      {
        'name': 'Algorithm Design',
        'icon': Icons.psychology_alt,
        'color': const Color(0xFFFF5722),
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimations = List.generate(
      skillCategories.length,
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
              // App Bar
              SliverAppBar(
                expandedHeight: 120,
                floating: true,
                pinned: true,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Technical Skills',
                    style: TextStyle(
                      color: theme.textTheme.headlineMedium?.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                ),
              ),

              // Skills Content
              SliverPadding(
                padding: EdgeInsets.all(isDesktop ? 32 : (isTablet ? 24 : 16)),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final category = skillCategories.keys.elementAt(index);
                    final skills = skillCategories[category]!;

                    return SlideTransition(
                      position: _slideAnimations[index],
                      child: FadeTransition(
                        opacity: _controller,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: GlassmorphicContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category,
                                  style: theme.textTheme.headlineMedium
                                      ?.copyWith(
                                        fontSize:
                                            isDesktop
                                                ? 24
                                                : (isTablet ? 20 : 18),
                                      ),
                                ),
                                const SizedBox(height: 20),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            isDesktop ? 4 : (isTablet ? 3 : 2),
                                        childAspectRatio: 1.2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                      ),
                                  itemCount: skills.length,
                                  itemBuilder: (context, skillIndex) {
                                    return _SkillTileWidget(
                                      skillData: skills[skillIndex],
                                      delay: skillIndex * 100,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }, childCount: skillCategories.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillTileWidget extends StatefulWidget {
  final Map<String, dynamic> skillData;
  final int delay;

  const _SkillTileWidget({required this.skillData, this.delay = 0});

  @override
  State<_SkillTileWidget> createState() => _SkillTileWidgetState();
}

class _SkillTileWidgetState extends State<_SkillTileWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _hoverAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _hoverAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final skillName = widget.skillData['name'] as String;
    final skillIcon = widget.skillData['icon'] as IconData;
    final skillColor = widget.skillData['color'] as Color;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedBuilder(
            animation: _hoverAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _hoverAnimation.value,
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() => _isHovered = true);
                    _hoverController.forward();
                  },
                  onExit: (_) {
                    setState(() => _isHovered = false);
                    _hoverController.reverse();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:
                            _isHovered
                                ? skillColor
                                : theme.primaryColor.withValues(alpha: 0.2),
                        width: _isHovered ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              _isHovered
                                  ? skillColor.withValues(alpha: 0.3)
                                  : Colors.black.withValues(alpha: 0.05),
                          blurRadius: _isHovered ? 15 : 5,
                          spreadRadius: _isHovered ? 2 : 0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color:
                                _isHovered
                                    ? skillColor.withValues(alpha: 0.2)
                                    : skillColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            skillIcon,
                            color:
                                _isHovered
                                    ? skillColor
                                    : skillColor.withValues(alpha: 0.8),
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          skillName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                _isHovered
                                    ? skillColor
                                    : theme.textTheme.titleMedium?.color,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
