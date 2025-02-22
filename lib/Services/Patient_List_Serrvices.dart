import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/urls.dart';
import '../Model/Patient_Model.dart';

class PatientService {
  Future<List<Patient>> getPatient() async {
    List<Patient> data = [];
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
        "${AppUrl.baseUrl}PatientList",
        options: Options(
          headers: headers,
        ),
      );
      if (kDebugMode) {
        print(response);
      }
      var json = response.data;
      response.data['patient']
          .map((e) => data.add(Patient.fromJson(e)))
          .toList();
      // data = List<PatientModel>.from(json.map((x) => PatientModel.fromJson(x)));
      print(json);
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
    }
    return data;
  }
}
