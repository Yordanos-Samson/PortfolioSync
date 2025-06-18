import 'package:equatable/equatable.dart';

abstract class GithubState extends Equatable {
  @override
  List<Object> get props => [];
}

class GithubInitial extends GithubState {}

class GithubLoading extends GithubState {}

class GithubLoaded extends GithubState {
  final List<dynamic> repos; // Adjust type based on your model
  GithubLoaded(this.repos);
  @override
  List<Object> get props => [repos];
}

class GithubError extends GithubState {
  final String message;
  GithubError(this.message);
  @override
  List<Object> get props => [message];
}
