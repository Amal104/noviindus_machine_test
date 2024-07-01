import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/urls.dart';
import '../Model/Branch_Model.dart';

class BranchListServices {
  Future<List<Branch>> getBranch() async {
    List<Branch> data = [];
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
        "${AppUrl.baseUrl}BranchList",
        options: Options(
          headers: headers,
        ),
      );
      if (kDebugMode) {
        print(response);
      }
      var json = response.data;
      // response.data['branches']
      //     .map((e) => data.add(Branch.fromJson(e)))
      //     .toList();
      data = List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x)));
      print(json);
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
    }
    return data;
  }
}
