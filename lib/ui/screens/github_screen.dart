import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/github/github_bloc.dart';
import '../widgets/repo_card.dart';
import '../../blocs/github/github_state.dart';

class GithubScreen extends StatelessWidget {
  const GithubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GitHub Repositories')),
      body: BlocBuilder<GithubBloc, GithubState>(
        builder: (context, state) {
          if (state is GithubLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GithubLoaded) {
            return ListView.builder(
              itemCount: state.repos.length,
              itemBuilder:
                  (context, index) => RepoCard(repo: state.repos[index]),
            );
          } else if (state is GithubError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}
