import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neoshot_mobile/utils/model/post_model.dart';
import 'package:neoshot_mobile/utils/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<PostEvent>((event, emit) async{
      if(event is PostLoadEvent){
        final List<Post> posts;
        emit(PostLoadingState());
        try {
          posts = (await postRepository.getPosts())!;
          return emit(PostLoadedState(posts: posts));
        } catch(exception) {
          return emit(PostErrorState());
        }
      }
    });
  }
}
