import 'package:doctor_dreams/home.dart';
import 'package:doctor_dreams/screens/Auth/authScreen.dart';
import 'package:doctor_dreams/screens/Auth/login.dart';
import 'package:doctor_dreams/screens/Auth/signup.dart';
import 'package:doctor_dreams/screens/Auth/tuya/tuyaAuthScreen.dart';
import 'package:doctor_dreams/screens/Auth/tuya/tuyaLogin.dart';
import 'package:doctor_dreams/screens/Auth/tuya/tuyaSignup.dart';
import 'package:doctor_dreams/screens/Auth/tuya/tuya_otp.dart';
import 'package:doctor_dreams/screens/hardware/pairDevice.dart';
import 'package:doctor_dreams/screens/hardware/productList.dart';
import 'package:doctor_dreams/screens/hardware/sleep_belt/reportDevice.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Dreams',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        AuthScreen.id: (context) => AuthScreen(),
        Login.id: (context) => Login(),
        Signup.id: (context) => Signup(),
        Home.id: (context) => Home(),
        PairDevice.id: (context) => PairDevice(),
        productList.id: (context) => productList(),
        TuyaAuthScreen.id: (context) => TuyaAuthScreen(),
        TuyaLoginScreen.id: (context) => TuyaLoginScreen(),
        TuyaSingupScreen.id: (context) => TuyaSingupScreen(),
        //TuyaOtpScreen.id: (context) => TuyaOtpScreen(),
      },
    );
  }
}
