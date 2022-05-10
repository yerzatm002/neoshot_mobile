import 'package:neoshot_mobile/utils/model/post_model.dart';
import 'package:neoshot_mobile/utils/services/post_service.dart';

class PostRepository {

  final PostService _postService = PostService();

  Future<List<Post>?>? getPosts() => _postService.getPosts();
}