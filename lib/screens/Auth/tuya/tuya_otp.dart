import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/screens/hardware/pairDevice.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:tuya_ui_bizbundle/tuya_ui_bizbundle.dart';

class TuyaOtpScreen extends StatefulWidget {
  static const String id = 'tuya_otp_screen';

  TuyaOtpScreen({Key? key,required this.email,required this.password}) : super(key: key);
  String email;
  String password;
  @override
  _TuyaOtpScreenState createState() => _TuyaOtpScreenState(this.email, this.password);
}

class _TuyaOtpScreenState extends State<TuyaOtpScreen> {
  String otp = '';
  String email;
  String password;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  _TuyaOtpScreenState(this.email,this.password);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppPrimaryBar(),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 6, bottom: 0, top: 100),
                child: Text(
                  "Enter OTP",
                  style: TextStyle(
                    shadows: [
                      Shadow(color: AppColors.primary, offset: Offset(0, -5))
                    ],
                    fontSize: 22.00,
                    fontWeight: FontWeight.bold,
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationThickness: 3,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 40, right: 35, top: 10, bottom: 0),
                              // color: Colors.red,
                              child: Text(
                                "OTP",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 35, right: 35, top: 16),
                        child: TextFormField(
                          obscureText: true,
                          initialValue: otp,
                          onSaved: (val) => otp = val.toString(),
                          validator: (val) => val.toString().length > 0
                              ? null
                              : 'OTP not be empty',
                          decoration: InputDecoration(
                            hintText: 'OTP',
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.lightBlueAccent, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.lightBlueAccent, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.00,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 100),
                          child: otpVerify(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar());
  }

// otpVerify Button
  GestureDetector otpVerify(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _submitOtp(context);
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
          'Verify',
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
          child: Image.asset('assets/logo.png', height: 50.00),
        ),
      ),
    );
  }

  _submitOtp(BuildContext context) async {
    key.currentState?.save();
    if (key.currentState!.validate()) {
      // TODO:
      print("form is validated");
      print('Call OTP');
      String? message=await TuyaUiBizbundle.reg("+91", "0", password, email, otp);
      if(message!=null){
        if(message.startsWith("success")) {
          String? message2 = await TuyaUiBizbundle.login("+91", "0", password, email);
          if(message2!=null) {
            if (message2.startsWith("success")) {
              Navigator.of(context).pop(true);
            } else {
              createAlertDialog(context, message2.replaceRange(0, 5, ""));
            }
          }else{
            createAlertDialog(context, "Error validating otp");
          }
        }else{
          createAlertDialog(context, message.replaceRange(0, 5, ""));
        }
      }else{
        createAlertDialog(context, "Error validating otp");
      }
    } else {
      print("Validate failed");
    }
  }
}

// alert
createAlertDialog(BuildContext context, msg) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            MaterialButton(
                elevation: 5.0,
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      });
}

// class BlueCirclePainter extends CustomPainter {
//   final Paint mainColor = Paint()..color = AppColors.primary;
//   final Paint secondaryColor = Paint()..color = AppColors.secondary;
//   final Paint secondaryLightColor = Paint()..color = AppColors.secondary_light;
//   @override
//   void paint(Canvas canvas, Size size) {
//     final textStyle = TextStyle(
//         color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold);
//     final textSpan = TextSpan(
//       text: 'Add\nAddress',
//       style: textStyle,
//     );
//     final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout(
//       minWidth: 0,
//       maxWidth: size.width,
//     );
//     final xCenter = (size.width - textPainter.width) / 5;
//     final yCenter = (size.height - textPainter.height) / 4;
//     final offset = Offset(xCenter, yCenter);

//     final height = size.height;
//     final width = size.width;
//     Paint paint = Paint();

//     var firstCirclePath = Rect.fromLTRB(
//         size.width * 1 + 30, -20, size.width * 0.70, size.height * 0.40);

//     var secondCirclePath = Rect.fromLTRB(
//         size.width * 1 + 60, 30, size.width * 0.65, size.height * 0.70);

//     var thirdCirclePath =
//         Rect.fromLTRB(-80, 320, size.width * 0.22, size.height * 0.40);

//     var fourCirclePath =
//         Rect.fromLTRB(-50, 310, size.width * 0.42, size.height * 0.20);

//     var mainCircle =
//         Rect.fromLTRB(-100, -300, size.width * 0.90, size.height * 0.55);

//     final Path secondCircle = Path()..addOval(secondCirclePath);
//     final Path circle = Path()..addOval(mainCircle);
//     final Path firstCircle = Path()..addOval(firstCirclePath);
//     final Path thirdCircle = Path()..addOval(thirdCirclePath);
//     final Path fourCircle = Path()..addOval(fourCirclePath);

//     // canvas.drawPath(fourCircle, secondaryLightColor);
//     // canvas.drawPath(thirdCircle, secondaryColor);
//     canvas.drawPath(circle, mainColor);
//     canvas.drawPath(secondCircle, secondaryLightColor);
//     canvas.drawPath(firstCircle, secondaryColor);
//     textPainter.paint(canvas, offset);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return oldDelegate != this;
//   }
// }
