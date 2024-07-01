import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noviindus_machine_test/Constants/Size.dart';
import 'package:noviindus_machine_test/Provider/Login_Provider.dart';
import 'package:provider/provider.dart';

import '../../Constants/Text.dart';
import '../../Utils/AppColor.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height(context) * 0.3,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/login_image.jpeg'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Heading
                      const Text(
                        ConstText.LoginHead,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Email TextField
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text("Email"),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: AppColor.lightGrey,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextField(
                          controller: provider.usernameConroller,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Password TextField
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text("Password"),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: AppColor.lightGrey,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextField(
                          controller: provider.passwordConroller,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter password",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height(context) * 0.1,
                      ),

                      //Login Button

                      GestureDetector(
                        onTap: () async {
                          await provider.login(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
