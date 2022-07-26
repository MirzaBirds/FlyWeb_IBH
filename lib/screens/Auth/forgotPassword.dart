import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/config/graphql.dart';
import 'package:doctor_dreams/config/logoSize.dart';
import 'package:doctor_dreams/services/shopify/customerAuth.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String conformPassword = '';
  bool isMobileValid = true;
  final GraphQLClient _client = getGraphQLClient();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppPrimaryBar(isSleetBelt: true),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 6, bottom: 0, top: 100),
              // color: Colors.red,
              child: Text(
                "Forgot Password",
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
              // padding: EdgeInsets.only(
              //   bottom: 10.00,
              // ),
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
                    // Container(
                    //   width: double.infinity,
                    //   height: 250.0,
                    //   child: CustomPaint(
                    //     painter: BlueCirclePainter(),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Mobile Number
                    Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 40, right: 35, top: 10, bottom: 0),
                            // color: Colors.red,
                            child: Text(
                              "Email",
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
                        // obscureText: true,
                        initialValue: email,
                        onSaved: (val) => email = val.toString(),
                        validator: (val) => val.toString().length > 0
                            ? null
                            : 'Email not be empty',
                        decoration: InputDecoration(
                          // labelText: 'Password',
                          hintText: 'Email',
                          // icon: Icon(Icons.password),
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
                        child: signUp(context)),

                    // bottom_logo(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavBar()
    );
  }

// Top Section Custom shapes

// Signup Button
  GestureDetector signUp(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("SIGNUP --> button press");
        _submitSignup(context);
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
          'Reset',
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

  _submitSignup(BuildContext context) async {
    key.currentState?.save();
    if (key.currentState!.validate()) {
      print("form is validated");
      // Check password
      print('in reset password method');
      // if (password == conformPassword) {
      print("password is correct !!");
      final MutationOptions options = MutationOptions(
        document: gql(CustomerAuth.forgotPassword),
        variables: <String, dynamic>{"email": email},
      );

      final QueryResult result = await _client.mutate(options);
      print("++++++++++++++++++++208+++++++++++++++++++++++++++");
      print(result.data?['customerRecover']);

      // if (result.hasException) {
      //   print(result.exception.toString());
      //   return;
      // }
      if (result.data?['customerRecover'] == null) {
        print("++++++++++++++226+++++++++++++++");
        createAlertDialogForgotPassword(context,
            "Resetting password limit exceeded. Please try again after some time.");
      } else if (result
          .data?['customerRecover']['customerUserErrors'].isEmpty) {
        print("password link share successfully over email");

        createAlertDialogForgotPassword(
            context, "Check your email to reset password");

        // Navigator.pop(context);
      } else if (result.data?['customerRecover']['customerUserErrors'][0]
              ['code'] ==
          "UNIDENTIFIED_CUSTOMER") {
        print("In please check email");
        createAlertDialogForgotPassword(
            context, "Please check the email address");
      }
    } else {
      print("Validate failed");
    }
  }
}

class BlueCirclePainter extends CustomPainter {
  final Paint mainColor = Paint()..color = AppColors.primary;
  final Paint secondaryColor = Paint()..color = AppColors.secondary;
  final Paint secondaryLightColor = Paint()..color = AppColors.secondary_light;
  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
        color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold);
    final textSpan = TextSpan(
      text: 'Add\nAddress',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = (size.width - textPainter.width) / 5;
    final yCenter = (size.height - textPainter.height) / 4;
    final offset = Offset(xCenter, yCenter);

    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    var firstCirclePath = Rect.fromLTRB(
        size.width * 1 + 30, -20, size.width * 0.70, size.height * 0.40);

    var secondCirclePath = Rect.fromLTRB(
        size.width * 1 + 60, 30, size.width * 0.65, size.height * 0.70);

    var thirdCirclePath =
        Rect.fromLTRB(-80, 320, size.width * 0.22, size.height * 0.40);

    var fourCirclePath =
        Rect.fromLTRB(-50, 310, size.width * 0.42, size.height * 0.20);

    var mainCircle =
        Rect.fromLTRB(-100, -300, size.width * 0.90, size.height * 0.55);

    final Path secondCircle = Path()..addOval(secondCirclePath);
    final Path circle = Path()..addOval(mainCircle);
    final Path firstCircle = Path()..addOval(firstCirclePath);
    final Path thirdCircle = Path()..addOval(thirdCirclePath);
    final Path fourCircle = Path()..addOval(fourCirclePath);

    // canvas.drawPath(fourCircle, secondaryLightColor);
    // canvas.drawPath(thirdCircle, secondaryColor);
    canvas.drawPath(circle, mainColor);
    canvas.drawPath(secondCircle, secondaryLightColor);
    canvas.drawPath(firstCircle, secondaryColor);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

createAlertDialogForgotPassword(BuildContext context, msg) {
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
