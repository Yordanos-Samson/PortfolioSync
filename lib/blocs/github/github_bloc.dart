import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/github_service.dart';
import 'github_event.dart';
import 'github_state.dart';

class GithubBloc extends Bloc<GithubEvent, GithubState> {
  final GithubService githubService;

  GithubBloc(this.githubService) : super(GithubInitial()) {
    on<FetchGithubReposEvent>((event, emit) async {
      emit(GithubLoading());
      try {
        final repos = await githubService.fetchRepos(event.username);
        emit(GithubLoaded(repos));
      } catch (e) {
        emit(GithubError(e.toString()));
      }
    });
  }
}
