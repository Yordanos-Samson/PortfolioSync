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

  static final Map<String, List<Skill>> skillCategories = {
    'Mobile Development': [
      Skill(
        name: 'Flutter',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg',
      ),
      Skill(
        name: 'Dart',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/dart/dart-original.svg',
      ),
      Skill(
        name: 'Android',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/android/android-original.svg',
      ),
    ],
    'Frontend Development': [
      Skill(
        name: 'React',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/react/react-original.svg',
      ),
      Skill(
        name: 'JavaScript',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/javascript/javascript-original.svg',
      ),
      Skill(
        name: 'HTML5',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/html5/html5-original.svg',
      ),
      Skill(
        name: 'CSS3',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/css3/css3-original.svg',
      ),
    ],
    'Backend Development': [
      Skill(
        name: 'Node.js',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/nodejs/nodejs-original.svg',
      ),
      Skill(
        name: 'Python',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original.svg',
      ),
      Skill(
        name: 'C++',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/cplusplus/cplusplus-original.svg',
      ),
    ],
    'Database & Cloud': [
      Skill(
        name: 'PostgreSQL',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/postgresql/postgresql-original.svg',
      ),
      Skill(
        name: 'Supabase',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/supabase/supabase-original.svg',
      ),
      Skill(
        name: 'Firebase',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/firebase/firebase-plain.svg',
      ),
    ],
    'Specialized Technologies': [
      Skill(
        name: 'WebSocket',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/socketio/socketio-original.svg',
      ),
      Skill(
        name: 'Chapa Payment',
        iconPath: 'https://images.chapa.co/brands/chapa-icon.svg',
      ),
      Skill(
        name: 'REST API',
        iconPath:
            'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/fastapi/fastapi-original.svg',
      ),
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
                                      skill: skills[skillIndex],
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
  final Skill skill;
  final int delay;

  const _SkillTileWidget({required this.skill, this.delay = 0});

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
                                ? theme.primaryColor
                                : theme.primaryColor.withValues(alpha: 0.2),
                        width: _isHovered ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              _isHovered
                                  ? theme.primaryColor.withValues(alpha: 0.3)
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
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.network(
                            widget.skill.iconPath,
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: theme.primaryColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: theme.primaryColor.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.code,
                                  color: theme.primaryColor,
                                  size: 20,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.skill.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                _isHovered
                                    ? theme.primaryColor
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
