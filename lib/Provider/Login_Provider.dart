import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:noviindus_machine_test/view/screens/Home_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/urls.dart';
import '../Model/User_Model.dart';
import '../Utils/AppColor.dart';
import '../Utils/CustomSnackbar.dart';

class LoginProvider extends ChangeNotifier {
  final usernameConroller = TextEditingController();
  final passwordConroller = TextEditingController();

  final _dio = Dio();

  Future<void> login(BuildContext context) async {
    try {
      if (usernameConroller.text.isNotEmpty &&
          passwordConroller.text.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var formData = FormData.fromMap({
          'username': usernameConroller.text,
          'password': passwordConroller.text,
        });
        if (kDebugMode) {
          print("${AppUrl.baseUrl}Login");
        }
        var response = await _dio.post(
          "${AppUrl.baseUrl}Login",
          data: formData,
        );
        if (response.statusCode == 200) {
          final data = User.fromJson(response.data);
          final token = data.token;

          if (kDebugMode) {
            print(response.data);
            print(token);
          }

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("logintoken", token);
          Customsnackbar.showSnackBar(
              context, "Yaay!", "Login Successful", AppColor.green);
          Get.off(() => const HomeScreen());
        } else {
          var status = response.data;
          Customsnackbar.showSnackBar(
              context, "Oops!", "$status", AppColor.green);
        }
      } else {
        Customsnackbar.showSnackBar(
            context, "Oops!", "Enter valid data", AppColor.green);
      }
    } catch (e) {
      print(e);
    }
  }

  // logout() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove("logintoken");
  //   Get.off(() => const LoginScreen());
  // }
}
