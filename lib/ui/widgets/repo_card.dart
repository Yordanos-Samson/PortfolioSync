import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/github_repo.dart';

class RepoCard extends StatefulWidget {
  final dynamic repo; // Keep dynamic for backward compatibility
  final int delay;

  const RepoCard({super.key, required this.repo, this.delay = 0});

  @override
  State<RepoCard> createState() => _RepoCardState();
}

class _RepoCardState extends State<RepoCard> with TickerProviderStateMixin {
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

    // Safely extract data from both GithubRepo model and raw JSON
    String name;
    String description;
    int stars;
    String url;
    String? language;
    List<String> topics;

    if (widget.repo is GithubRepo) {
      final repo = widget.repo as GithubRepo;
      name = repo.name;
      description = repo.description;
      stars = repo.stars;
      url = repo.url;
      language = repo.language;
      topics = repo.topics;
    } else {
      // Handle raw JSON data
      final repoData = widget.repo as Map<String, dynamic>;
      name = repoData['name'] ?? 'Unknown Repository';
      description = repoData['description'] ?? 'No description available';
      stars = repoData['stargazers_count'] ?? 0;
      url = repoData['html_url'] ?? '';
      language = repoData['language']; // Can be null
      topics =
          repoData['topics'] != null
              ? List<String>.from(repoData['topics'])
              : <String>[];
    }

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
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: theme.primaryColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.folder_rounded,
                                  color: theme.primaryColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  name,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        _isHovered
                                            ? theme.primaryColor
                                            : theme.textTheme.titleLarge?.color,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    stars.toString(),
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            description,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.4,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              // Language badge (only show if language exists)
                              if (language != null && language!.isNotEmpty) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    language!,
                                    style: TextStyle(
                                      color: theme.primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],

                              // Topics (show first 2)
                              ...topics
                                  .take(2)
                                  .map(
                                    (topic) => Container(
                                      margin: const EdgeInsets.only(right: 6),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        topic,
                                        style: TextStyle(
                                          color:
                                              theme.textTheme.bodySmall?.color,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),

                              const Spacer(),

                              TextButton.icon(
                                onPressed: () async {
                                  if (url.isNotEmpty) {
                                    final uri = Uri.parse(url);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri);
                                    }
                                  }
                                },
                                icon: const Icon(
                                  Icons.open_in_new_rounded,
                                  size: 16,
                                ),
                                label: const Text('View'),
                                style: TextButton.styleFrom(
                                  foregroundColor: theme.primaryColor,
                                ),
                              ),
                            ],
                          ),
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
