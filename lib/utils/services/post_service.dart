import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:neoshot_mobile/configuration/configuration.dart';
import 'package:neoshot_mobile/utils/model/post_model.dart';
import 'package:neoshot_mobile/utils/services/upload_image_service.dart';

class PostService{

  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Save post
  Future<bool> savePost(String description, List<XFile>? images, List<String> tags) async {

    /// Image provider
    UploadImageService _imageProvider = UploadImageService();

    var url = Uri.parse(
        '${Configuration.host}api/v1/post/save');

    String? token = await storage.read(key: 'token');

    if (token != null) {
      var response = await http.post(
          url,
          body: jsonEncode({
            "id" : 0,
            "tags" : tags,
            "description" : description
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          }
      );

      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['httpStatus'] == 200) {

          if(images != null) {
            bool imageResult = await _imageProvider.uploadPostImage(images, jsonDecode(response.body)['data']);

            if(imageResult) {
              return true;
            } else {
              return false;
            }
          } else {
            return true;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }

    } else {
      return false;
    }
  }

  /// Get reports
  Future<List<Post>?> getPosts() async {

    List<Post> posts = [];

    var url = Uri.parse(
        '${Configuration.host}api/v1/post/findAll');

    String? token = await storage.read(key: 'token');

    if (token != null) {
      var response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          }
      );
      print(response);
      if (response.body.isNotEmpty) {
        final result = postModelFromJson(response.body);
        posts.addAll(result.content);
        return posts;
      } else {
        throw Exception('Failed to load post');
      }
    }
    return null;
    }
}