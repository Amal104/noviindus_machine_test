import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/urls.dart';
import '../Model/Treatment_Model.dart';

class TreatmentListServices {
  Future<List<Treatment>> getTreatment() async {
    List<Treatment> data = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("logintoken");
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    if (kDebugMode) {
      print(token);
    }
    try {
      var response = await Dio().get(
        "${AppUrl.baseUrl}TreatmentList",
        options: Options(
          headers: headers,
        ),
      );
      if (kDebugMode) {
        print(response);
      }
      var json = response.data;
      data = List<Treatment>.from(
          json["treatments"].map((x) => Treatment.fromJson(x)));
      print(json);
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
    }
    return data;
  }
}
