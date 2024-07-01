import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/urls.dart';
import '../Model/Patient_Model.dart';

class PatientService {
  Future<List<PatientModel>?> getPatient() async {
    Dio _dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("logintoken");
    if (kDebugMode) {
      print(token);
    }
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";
      var response = await _dio.get("${AppUrl.baseUrl}PatientList");
      if (kDebugMode) {
        print(response);
      }
      var json = response.data;
      List<PatientModel>? data =
          List<PatientModel>.from(json.map((x) => PatientModel.fromJson(x)));
      if (kDebugMode) {
        print(json);
      }
      return data;
    } catch (e) {
      if (e is DioException) {
        e.response?.data;
      }
    }
  }
}
