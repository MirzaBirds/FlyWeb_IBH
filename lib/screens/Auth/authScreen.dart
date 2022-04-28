import 'dart:convert';

import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/config/logoSize.dart';
import 'package:doctor_dreams/screens/Auth/login.dart';
import 'package:doctor_dreams/screens/Auth/signup.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  static const String id = 'auth_screen';
  // const LoginScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 30.00),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 400.0,
                child: CustomPaint(
                  painter: BlueCirclePainter(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: signUp(context),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: logIn(context)),
              bottom_logo(),
            ],
          ),
        ),
      ),
    );
  }

// Top Section Custom shapes
  // customShape(BuildContext context) {}
// Log In Button
  GestureDetector logIn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("button press");

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(100),
              bottomRight: Radius.circular(100),
              topLeft: Radius.circular(100),
              bottomLeft: Radius.circular(100),
            ),
            color: AppColors.secondary),
        child: Text(
          'Log In',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

// Signup Button
  GestureDetector signUp(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Signup()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(100),
            bottomRight: Radius.circular(100),
            topLeft: Radius.circular(100),
            bottomLeft: Radius.circular(100),
          ),
          color: AppColors.primary,
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

// Bottom Logo
  Expanded bottom_logo() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(00),
          child: Image.asset('assets/logo.png', height: LogoSize.height),
        ),
      ),
    );
  }
}

class BlueCirclePainter extends CustomPainter {
  final Paint mainColor = Paint()..color = AppColors.primary;
  final Paint secondaryColor = Paint()..color = AppColors.secondary;
  final Paint secondaryLightColor = Paint()..color = AppColors.secondary_light;
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    var firstCirclePath = Rect.fromLTRB(
        size.width * 1 + 30, -20, size.width * 0.70, size.height * 0.30);

    var secondCirclePath = Rect.fromLTRB(
        size.width * 1 + 60, 70, size.width * 0.75, size.height * 0.50);

    var thirdCirclePath =
        Rect.fromLTRB(-80, 320, size.width * 0.22, size.height * 0.40);

    var fourCirclePath =
        Rect.fromLTRB(-50, 310, size.width * 0.42, size.height * 0.20);

    var mainCircle =
        Rect.fromLTRB(-100, -300, size.width * 0.90, size.height * 0.55);

    // Text : Welcome
    final textStyle = TextStyle(
        color: Colors.white, fontSize: 35, fontWeight: FontWeight.w600);
    final textSpan = TextSpan(
        text: 'Dreamers',
        style: GoogleFonts.dancingScript(
            color: Colors.white, fontSize: 55, fontWeight: FontWeight.w600));
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = (size.width - textPainter.width) / 4;
    final yCenter = (size.height - textPainter.height) / 2.9;
    final offset = Offset(xCenter, yCenter);

    // Text : Dreamer
    final textStyle1 = TextStyle(
        color: Colors.white, fontSize: 35, fontWeight: FontWeight.w800);
    final textSpan1 = TextSpan(
      text: 'Welcome',
      style: textStyle,
    );
    final textPainter1 = TextPainter(
      text: textSpan1,
      textDirection: TextDirection.ltr,
    );
    textPainter1.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter1 = (size.width - textPainter1.width) / 3.3;
    final yCenter1 = (size.height - textPainter1.height) / 4.2;
    final offset1 = Offset(xCenter1, yCenter1);

    final Path secondCircle = Path()..addOval(secondCirclePath);
    final Path circle = Path()..addOval(mainCircle);
    final Path firstCircle = Path()..addOval(firstCirclePath);
    final Path thirdCircle = Path()..addOval(thirdCirclePath);
    final Path fourCircle = Path()..addOval(fourCirclePath);

    canvas.drawPath(fourCircle, secondaryLightColor);
    canvas.drawPath(thirdCircle, secondaryColor);
    canvas.drawPath(circle, mainColor);
    canvas.drawPath(secondCircle, secondaryLightColor);
    canvas.drawPath(firstCircle, secondaryColor);
    textPainter.paint(canvas, offset);
    textPainter1.paint(canvas, offset1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
