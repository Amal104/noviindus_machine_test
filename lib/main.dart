import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noviindus_machine_test/Provider/Login_Provider.dart';
import 'package:noviindus_machine_test/Provider/Patient_Provider.dart';
import 'package:noviindus_machine_test/Provider/Register_Provider.dart';
import 'package:noviindus_machine_test/view/screens/Splash_Screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PatientProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterProvider(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade900),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
