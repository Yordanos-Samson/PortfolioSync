import 'package:flutter/material.dart';
import 'glassmorphic_container.dart';

class ProfileHeader extends StatefulWidget {
  final bool isTablet;
  final bool isDesktop;

  const ProfileHeader({
    super.key,
    required this.isTablet,
    required this.isDesktop,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avatarSize =
        widget.isDesktop ? 120.0 : (widget.isTablet ? 100.0 : 80.0);

    return GlassmorphicContainer(
      child: Column(
        children: [
          // Profile Image with Animation
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: avatarSize + 8,
                  height: avatarSize + 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: CircleAvatar(
                      radius: avatarSize / 2,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.network(
                          'https://avatars.githubusercontent.com/Yordanos-Samson',
                          width: avatarSize,
                          height: avatarSize,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: avatarSize,
                              height: avatarSize,
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: avatarSize,
                              height: avatarSize,
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // Name and Title
          Text(
            'Yordanos Samson',
            style: theme.textTheme.headlineLarge?.copyWith(
              fontSize: widget.isDesktop ? 36 : (widget.isTablet ? 28 : 24),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Senior Flutter Developer',
              style: TextStyle(
                color: Colors.white,
                fontSize: widget.isDesktop ? 18 : (widget.isTablet ? 16 : 14),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            'Passionate mobile and web developer specializing in Flutter, React, and full-stack development. Expert in healthcare technology and payment integrations.',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: widget.isDesktop ? 16 : 14,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 24),

          // Specializations
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildSpecializationChip('🚀 Full-Stack', theme),
              _buildSpecializationChip('📱 Mobile Expert', theme),
              _buildSpecializationChip('🏥 Healthcare Tech', theme),
              _buildSpecializationChip('💳 Payment Integration', theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecializationChip(String text, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: 0.1),
        border: Border.all(color: theme.primaryColor.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: theme.primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
