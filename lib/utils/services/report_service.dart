import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:neoshot_mobile/configuration/configuration.dart';
import 'package:http/http.dart' as http;
import 'package:neoshot_mobile/utils/model/report_model.dart';

class ReportService {
  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Save report
  Future<bool> saveReport(String text) async {
    var url = Uri.parse(
        '${Configuration.host}api/v1/report/save');

    String? token = await storage.read(key: 'token');

    if (token != null) {
      var response = await http.post(
          url,
          body: jsonEncode({
            "id": 0,
            "text": text
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          }
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  /// Get reports
  Future<List<ReportModel>?> getReport() async {

    List<ReportModel> reports = [];

    var url = Uri.parse(
        '${Configuration.host}api/v1/report');

    String? token = await storage.read(key: 'token');

    if (token != null) {
      var response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          }
      );

      if (response.body.isNotEmpty) {
        List<dynamic> values=<dynamic>[];
        values = json.decode(response.body);
        if(values.isNotEmpty){
          for(int i=0;i<values.length;i++){
            if(values[i]!=null){
              Map<String,dynamic> map=values[i];
              reports.add(ReportModel.fromJson(map));
            }
          }
        }
        return reports;
      } else {
        throw Exception('Failed to load post');
      }
    }
    return null;
  }
}