import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:neoshot_mobile/configuration/configuration.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UploadImageService{
  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();

  bool isImage(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType!.startsWith('image/');
  }

  Future<bool> uploadUserImage(int id, String photo, String fileName) async {
    String token = (await storage.read(key: 'token'))!;

    var formData = FormData.fromMap(
        {
          'file':
          await MultipartFile.fromFile(photo,filename: fileName,
          contentType: MediaType('image', 'png')),
          "type": "image/png"
        }
    );

    var response = await Dio().post(
        '${Configuration.imageUploadUrl}api/v1/storage/save/user/image?userId=$id',
        data: formData,
        onSendProgress: (int sent, int total) {
        },
        options: Options(
            headers: {
              'Content-Type':'application/json',
              'Authorization': token
            }
        )
    );
    if (response.statusCode == 200) {
      print(response);
      return true;
    } else {
      return false;
    }
  }

  /// Delete user avatar image
  Future<bool> deleteUserImage(int id) async {
    String token;
    token = (await storage.read(key: 'token'))!;
    var url = Uri.parse('${Configuration.host}api/v1/storage/delete/user/image/$id');

    var response = await http.delete(
      url,
      headers: {
        'Content-Type':'application/json',
        'Authorization': token
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> uploadPostImage(List<XFile> images, int id) async {
    String token = (await storage.read(key: 'token'))!;
    var formData = FormData.fromMap(
        {
          "files": [
            images.isNotEmpty ? await MultipartFile.fromFile(images[0].path,filename: images[0].name): null,
            images.length > 1 ? await MultipartFile.fromFile(images[1].path,filename: images[1].name) : null,
            images.length > 2 ? await MultipartFile.fromFile(images[2].path,filename: images[2].name) : null
          ]
        }
    );
    var response = await Dio().post(
        '${Configuration.imageUploadUrl}api/v1/storage/save/post/image?postId=$id',
        data: formData,
        options: Options(
            headers: {
              'Content-Type':'application/json',
              'Authorization': token
            }
        )
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
