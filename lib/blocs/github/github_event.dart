import 'package:equatable/equatable.dart';

abstract class GithubEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchGithubReposEvent extends GithubEvent {
  final String username;
  FetchGithubReposEvent(this.username);
  @override
  List<Object> get props => [username];
}