import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/urls.dart';
import '../Model/Patient_Model.dart';

class PatientService {
  Future<List<PatientModel>?> getPatient() async {
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
        "${AppUrl.baseUrl}PatientModel",
        options: Options(
          headers: headers,
        ),
      );
      if (kDebugMode) {
        print(response);
      }
      var json = response.data;
      List<PatientModel>? data =
          List<PatientModel>.from(json.map((x) => PatientModel.fromJson(x)));
      print(json);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }
}
