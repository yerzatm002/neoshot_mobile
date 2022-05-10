part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {

  final List<Post> posts;
  PostLoadedState({required this.posts});

}

class PostErrorState extends PostState {

}