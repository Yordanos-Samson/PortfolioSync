import 'package:flutter/material.dart';

class AnimatedNavButton extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;
  final int delay;

  const AnimatedNavButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.onTap,
    this.delay = 0,
  }) : super(key: key);

  @override
  State<AnimatedNavButton> createState() => _AnimatedNavButtonState();
}

class _AnimatedNavButtonState extends State<AnimatedNavButton>
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

    // Start animation with delay
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
                  child: GestureDetector(
                    onTap: widget.onTap,
                    onTapDown: (_) => _hoverController.forward(),
                    onTapUp: (_) => _hoverController.reverse(),
                    onTapCancel: () => _hoverController.reverse(),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient:
                            _isHovered
                                ? widget.gradient
                                : LinearGradient(
                                  colors: [theme.cardColor, theme.cardColor],
                                ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              _isHovered
                                  ? Colors.transparent
                                  : theme.primaryColor.withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                _isHovered
                                    ? theme.primaryColor.withOpacity(0.3)
                                    : Colors.black.withOpacity(0.05),
                            blurRadius: _isHovered ? 20 : 10,
                            spreadRadius: _isHovered ? 2 : 0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  _isHovered
                                      ? Colors.white.withOpacity(0.2)
                                      : theme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              widget.icon,
                              color:
                                  _isHovered
                                      ? Colors.white
                                      : theme.primaryColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        _isHovered
                                            ? Colors.white
                                            : theme.textTheme.titleLarge?.color,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.subtitle,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        _isHovered
                                            ? Colors.white.withOpacity(0.8)
                                            : theme.textTheme.bodyMedium?.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color:
                                _isHovered
                                    ? Colors.white
                                    : theme.primaryColor.withOpacity(0.7),
                            size: 16,
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
