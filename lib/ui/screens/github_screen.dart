import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/github/github_bloc.dart';
import '../../blocs/github/github_event.dart';
import '../widgets/repo_card.dart';
import '../../blocs/github/github_state.dart';

class GithubScreen extends StatefulWidget {
  const GithubScreen({super.key});

  @override
  State<GithubScreen> createState() => _GithubScreenState();
}

class _GithubScreenState extends State<GithubScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
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
                    'GitHub Repositories',
                    style: TextStyle(
                      color: theme.textTheme.headlineMedium?.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh_rounded),
                    onPressed: () {
                      context.read<GithubBloc>().add(
                        FetchGithubReposEvent('Yordanos-Samson'),
                      );
                    },
                  ),
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.all(isDesktop ? 32 : (isTablet ? 24 : 16)),
                sliver: BlocBuilder<GithubBloc, GithubState>(
                  builder: (context, state) {
                    if (state is GithubLoading) {
                      return SliverToBoxAdapter(child: _buildLoadingState());
                    } else if (state is GithubLoaded) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return FadeTransition(
                            opacity: _controller,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: _controller,
                                  curve: Interval(
                                    index * 0.1,
                                    0.5 + (index * 0.1),
                                    curve: Curves.easeOutCubic,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: RepoCard(
                                  repo: state.repos[index],
                                  delay: index * 100,
                                ),
                              ),
                            ),
                          );
                        }, childCount: state.repos.length),
                      );
                    } else if (state is GithubError) {
                      return SliverToBoxAdapter(
                        child: _buildErrorState(state.message, context),
                      );
                    }
                    return SliverToBoxAdapter(child: _buildEmptyState());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 16,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 16,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(String message, BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading repositories',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<GithubBloc>().add(
                FetchGithubReposEvent('Yordanos-Samson'),
              );
            },
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open_rounded, size: 64, color: theme.primaryColor),
          const SizedBox(height: 16),
          Text('No repositories found', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Check back later for updates',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
