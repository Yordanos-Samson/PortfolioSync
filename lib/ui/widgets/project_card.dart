import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/project.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final int delay;

  const ProjectCard({super.key, required this.project, this.delay = 0});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
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
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _hoverAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
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
    final techList = widget.project.techStack.split(', ');

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
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
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
                          blurRadius: _isHovered ? 20 : 10,
                          spreadRadius: _isHovered ? 2 : 0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF2563EB),
                                      Color(0xFF7C3AED),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.work_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  widget.project.title,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        _isHovered
                                            ? theme.primaryColor
                                            : theme.textTheme.titleLarge?.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.project.description,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                techList.map((tech) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: theme.primaryColor.withValues(
                                        alpha: 0.1,
                                      ),
                                      border: Border.all(
                                        color: theme.primaryColor.withValues(
                                          alpha: 0.3,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      tech.trim(),
                                      style: TextStyle(
                                        color: theme.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                          if (widget.project.githubUrl != null) ...[
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final url = Uri.parse(
                                    widget.project.githubUrl!,
                                  );
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  }
                                },
                                icon: const Icon(Icons.code_rounded),
                                label: const Text('View on GitHub'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
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
