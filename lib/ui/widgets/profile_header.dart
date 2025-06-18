import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'glassmorphic_container.dart';
import '../../services/pdf_service.dart';

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
  late AnimationController _buttonController;
  late Animation<double> _pulseAnimation;
  late List<Animation<Offset>> _buttonAnimations;

  final List<Map<String, dynamic>> contactLinks = [
    {
      'label': 'Email',
      'value': 'developerjb72@gmail.com',
      'icon': Icons.email_rounded,
      'url': 'mailto:developerjb72@gmail.com',
      'color': const Color(0xFFDC2626), // Professional Red
    },
    {
      'label': 'GitHub',
      'value': 'github.com/Yordanos-Samson',
      'icon': Icons.code_rounded,
      'url': 'https://github.com/Yordanos-Samson',
      'color': const Color(0xFF1F2937), // Professional Dark Gray
    },
    {
      'label': 'LinkedIn',
      'value': 'linkedin.com/in/yordanos-samson',
      'icon': Icons.work_rounded,
      'url': 'https://linkedin.com/in/yordanos-samson',
      'color': const Color(0xFF1E3A8A), // Professional Navy
    },
    {
      'label': 'Phone',
      'value': '+251944082479',
      'icon': Icons.phone_rounded,
      'url': 'tel:+251944082479',
      'color': const Color(0xFF059669), // Professional Green
    },
    {
      'label': 'Location',
      'value': 'Betel, Addis Ababa',
      'icon': Icons.location_on_rounded,
      'url': 'https://maps.google.com/?q=Betel,Addis+Ababa,Ethiopia',
      'color': const Color(0xFFD97706), // Professional Gold
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _buttonAnimations = List.generate(
      2, // For CV and Transcript buttons
      (index) =>
          Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
            CurvedAnimation(
              parent: _buttonController,
              curve: Interval(
                index * 0.3,
                0.7 + (index * 0.3),
                curve: Curves.easeOutCubic,
              ),
            ),
          ),
    );

    _buttonController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _buttonController.dispose();
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
                    color: const Color(0xFF1E3A8A), // Professional Navy
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withValues(alpha: 0.3),
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
              color: const Color(0xFF1E3A8A), // Professional Navy
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Dedicated Flutter Developer | Cross-Platform Solution Architect',
              style: TextStyle(
                color: Colors.white,
                fontSize: widget.isDesktop ? 16 : (widget.isTablet ? 14 : 12),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            'Passionate Flutter developer from Ethiopia with strong foundation in crafting efficient, high-quality mobile applications. Experienced in cross-platform development, backend integration, and full-stack solutions.',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: widget.isDesktop ? 16 : 14,
            ),
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 24),

          // Contact Links
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children:
                contactLinks
                    .map((contact) => _buildContactLink(contact, theme))
                    .toList(),
          ),

          const SizedBox(height: 24),

          // Download Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // CV Download Button
              SlideTransition(
                position: _buttonAnimations[0],
                child: _buildDownloadButton(
                  'Download CV',
                  Icons.download_rounded,
                  const Color(0xFF059669), // Professional Green
                  () => _downloadCV(),
                  theme,
                ),
              ),

              // Academic Transcript Button
              SlideTransition(
                position: _buttonAnimations[1],
                child: _buildDownloadButton(
                  'Academic Transcript',
                  Icons.school_rounded,
                  const Color(0xFFD97706), // Professional Gold
                  () => _downloadTranscript(),
                  theme,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Education Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.primaryColor.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school_rounded,
                      color: theme.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Bachelor of Information Systems',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'University of Bahir Dar • May 2022 - Jun 2025',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF059669).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Final Year Student',
                    style: TextStyle(
                      color: Color(0xFF059669),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Specializations
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildSpecializationChip(
                '🚀 Cross-Platform Expert',
                const Color(0xFF1E3A8A),
              ),
              _buildSpecializationChip(
                '📱 Mobile Development',
                const Color(0xFF059669),
              ),
              _buildSpecializationChip(
                '🏥 Healthcare Solutions',
                const Color(0xFFDC2626),
              ),
              _buildSpecializationChip(
                '🔐 Security Systems',
                const Color(0xFFD97706),
              ),
              _buildSpecializationChip(
                '🌐 Full-Stack Development',
                const Color(0xFF7C3AED),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactLink(Map<String, dynamic> contact, ThemeData theme) {
    return InkWell(
      onTap: () => _launchUrl(contact['url']),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: contact['color'].withValues(alpha: 0.1),
          border: Border.all(color: contact['color'].withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(contact['icon'], color: contact['color'], size: 16),
            const SizedBox(width: 6),
            Text(
              contact['label'],
              style: TextStyle(
                color: contact['color'],
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
    ThemeData theme,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 18),
          label: Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildSpecializationChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
      }
    }
  }

  void _downloadCV() async {
    try {
      await PDFService.downloadCV(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading CV: $e'),
            backgroundColor: const Color(0xFFDC2626),
          ),
        );
      }
    }
  }

  void _downloadTranscript() async {
    try {
      await PDFService.downloadTranscript(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading transcript: $e'),
            backgroundColor: const Color(0xFFDC2626),
          ),
        );
      }
    }
  }
}
