import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:neoshot_mobile/configuration/configuration.dart';
import 'package:neoshot_mobile/utils/model/user_model.dart';

class UserService {

  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Login query
  Future<int> login(String email, String password) async {
    var url = Uri.parse('${Configuration.host}api/v1/auth/login?email=$email&password=$password');

    var response = await http.post(
        url,
        headers: {
          'Content-Type':'application/json'
        }
    );

    print(response.body);

    FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
    String token;

    if(response.statusCode == 200) {
      token = jsonDecode(response.body)["data"];
      print(token);
      await flutterSecureStorage.write(key: 'token', value: "Bearer " + token);
      return response.statusCode;
    }
    return response.statusCode;
  }

  /// Get info about logged user
  Future<UserModel> getLoggedUser() async {
    String token;
    // try {
    token = (await storage.read(key: 'token'))!;
    var url = Uri.parse('${Configuration.host}api/v1/account');

    // try {
    var response = await http.get(
        url,
        headers: {
          'Content-Type':'application/json',
          'Authorization': token
        }
    );

    return UserModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))["data"]);

    /// Exception with response
    // } catch(e) {
    //   debugPrint("GetLoggedUserInfo exception in response data " + e.toString());
    // }

    /// Exception with token
    // } catch(e) {
    //   debugPrint("GetLoggedUserInfo exception in getting token: " + e.toString());
    // }

  }


  /// Register
  Future<int> register(String username, String email, String password) async {
    var url = Uri.parse('${Configuration.host}api/v1/auth/register');


    var response = await http.post(
        url,
        body: jsonEncode({
          "username": username,
          "id": 0,
          "password": password,
          "email": email
        }),
        headers: {
          'Content-Type':'application/json'
        }
    );
    print(response.body);

    return response.statusCode;
  }

  /// Confirm Verification to Email
  Future<int> activate(String email, String uuid) async {
    var url = Uri.parse('${Configuration.host}api/v1/auth/activate?email=$email&uuid=$uuid');


    var response = await http.put(
        url,
        headers: {
          'Content-Type':'application/json'
        }
    );
    print(response.body);

    return response.statusCode;
  }

  ///Reset Password
  Future<bool> resetPassword(String email) async {
    var url = Uri.parse('${Configuration.host}api/v1/auth/forgot?email=$email');

    var response = await http.put(
      url,
      headers: {
        'Content-Type':'application/json'
      },
    );
    if(response.statusCode == 200) {
      if(jsonDecode(response.body)["httpStatus"] == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  ///TODO: Getting new token


  /// User Change info
  Future<bool> changeUserInfo(String username, String instagram, String image) async {
    String token;
    token = (await storage.read(key: 'token'))!;
    var url = Uri.parse('${Configuration.host}api/v1/account/update');

    var response = await http.put(
        url,
        headers: {
          'Content-Type':'application/json',
          'Authorization': token
        },
        body: jsonEncode({
          "username": username,
          "instagram": instagram,
          "image": image
        })
    );


    if(response.statusCode == 200) {
      if(jsonDecode(response.body)["httpStatus"] == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /// User Change password
  Future<bool> changeUserPassword(String oldPassword, String newPassword) async {
    String token;
    token = (await storage.read(key: 'token'))!;
    var url = Uri.parse('${Configuration.host}api/v1/account/reset?oldPassword=$oldPassword&newPassword=$newPassword');

    var response = await http.put(
      url,
      headers: {
        'Content-Type':'application/json',
        'Authorization': token
      },
    );

    if(response.statusCode == 200) {
      if(jsonDecode(response.body)["httpStatus"] == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /// Get Cities
  // Future<List<CityModel>> getCities() async {
  //   var url = Uri.parse('${Configuration.host}public/auth/getAllCities');
  //
  //   var response = await http.get(
  //     url,
  //     headers: {
  //       'Content-Type':'application/json',
  //     },
  //   );
  //
  //   if(response.statusCode == 200) {
  //     if(jsonDecode(response.body)["httpStatus"] == 200) {
  //       List<dynamic> jsonResult = jsonDecode(
  //           utf8.decode(response.bodyBytes))["data"];
  //
  //       return jsonResult.map((json) => CityModel.fromJson(json)).toList();
  //     } else {
  //       throw Exception("Bad Request from http");
  //     }
  //   } else {
  //     throw Exception("Bad Request http status " + response.statusCode.toString());
  //   }
  //
  // }

  /// Change City
  // Future<bool> changeCity(int cityId) async {
  //   String token;
  //   token = (await storage.read(key: 'token'))!;
  //   var url = Uri.parse('${Configuration.host}private/user/changeUserCityByUserToken?id=$cityId');
  //
  //   var response = await http.put(
  //     url,
  //     headers: {
  //       'Content-Type':'application/json',
  //       'Authorization': token
  //     },
  //   );
  //
  //
  //   if(response.statusCode == 200) {
  //     if(jsonDecode(response.body)["httpStatus"] == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     return false;
  //   }
  // }


}