import 'dart:convert';
import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/config/graphql.dart';
import 'package:doctor_dreams/config/logoSize.dart';
import 'package:doctor_dreams/home.dart';
import 'package:doctor_dreams/screens/Auth/forgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:doctor_dreams/services/shopify/customerAuth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static const String id = 'login_screen';

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  bool isMobileValid = true;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GraphQLClient _client = getGraphQLClient();

  String login = '''
  mutation SignInWithEmailAndPassword(
    \$email: String!,
    \$password: String!,
){
    customerAccessTokenCreate(input:{
        email: \$email,
        password: \$password,
    }){
        customerAccessToken {
            accessToken
            expiresAt
        }
        customerUserErrors {
            code
            message
        }
    }
}
''';

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
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 300.0,
                child: CustomPaint(
                  painter: BlueCirclePainter(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Mobile Number
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.only(left: 40, right: 35, top: 16),
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
                  initialValue: email,
                  onSaved: (val) => email = val.toString(),
                  validator: (val) => val.toString().length > 1
                      ? null
                      : 'Enter valid Email Address',
                  decoration: InputDecoration(
                    // labelText: 'Email',
                    hintText: 'Enter email',
                    // icon: Icon(Icons.phone),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
              ),

              // Password
              // Mobile Number
              // SizedBox(
              //   height: 10,
              // ),

              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 40, right: 35, top: 16, bottom: 0),
                      // color: Colors.red,
                      child: Text(
                        "Password",
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
                  initialValue: password,
                  onSaved: (val) => password = val.toString(),
                  validator: (val) => val.toString().length > 0
                      ? null
                      : 'Password can not be empty',
                  decoration: InputDecoration(
                    // labelText: 'Password',
                    hintText: 'Enter Password',
                    // icon: Icon(Icons.password),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 15.00,
              ),
              Column(
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.blue.shade400,
                      // alignment:
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 40, right: 35, top: 8, bottom: 16),
                        // color: Colors.red,
                        child: Text(
                          "Forgot Password ?",
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                  ),
                ],
              ),

              Container(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: logIn(context)),
              SizedBox(
                height: 20,
              ),
              bottom_logo(),
            ],
          ),
        ),
      ),
    ));
  }

// Top Section Custom shapes
// Log In Button
  GestureDetector logIn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("button press");
        _submitLogin(context);
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Home()));
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
            color: AppColors.primary),
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
        print("button press");
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

// On press login button
  void _submitLogin(BuildContext context) async {
    key.currentState?.save();
    if (key.currentState!.validate()) {
      // initialize the shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('customerData');
      await prefs.remove('accessToken');

      // customer login with email and password
      final MutationOptions options = MutationOptions(
        document: gql(CustomerAuth.loginWithEmailAndPassword),
        variables: <String, dynamic>{"email": email, "password": password},
      );

      final QueryResult result = await _client.mutate(options);
      print("+++++++++++++++Data Result ++++++++++++++++");
      print(result.data);
      if (result.hasException) {
        print(result.exception.toString());
        return;
      }

      if (result.data?['customerAccessTokenCreate']['customerAccessToken'] !=
          null) {
        String customerAccessToken = result.data?['customerAccessTokenCreate']
            ['customerAccessToken']['accessToken'];
        // get user information
        final QueryOptions getCustomerData = QueryOptions(
          document: gql(
            CustomerAuth.getUserInfo,
          ),
          variables: {"customerAccessToken": customerAccessToken},
        );
        // Execute query
        final QueryResult customerInfo = await _client.query(getCustomerData);
        if (customerInfo.hasException) {
          print(customerInfo.exception.toString());
        }

        if (customerInfo.data != null) {
          if (result.data?['customerAccessTokenCreate']['customerAccessToken']
                  ['accessToken'] !=
              null) {
            // reset form key
            key.currentState?.reset();
            print(jsonEncode(customerInfo.data).runtimeType);
            //Store into shared preferences
            await prefs.setString(
                'accessToken', jsonEncode(customerAccessToken));
            await prefs.setString(
                'customerData', jsonEncode(customerInfo.data?['customer']));

            // Navigate to home page
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
            //TODO:TESTING --> get Shared preferences of user info
            String getUserInfo = await CustomerAuth().getUserData();
            String getUserAccessToken =
                await CustomerAuth().getUserAccessToken();
            print("+++++++++user info based on shared preferences ++++++++");
            print(json.decode(getUserInfo));
            print(json.decode(getUserAccessToken));
          }
          // } else if (result.data?['customerAccessTokenCreate']
          //         ['customerUserErrors'][0]['code'] ==
          //     "UNIDENTIFIED_CUSTOMER") {
          //   print("Unidentified customer");
          // } else if (result.data?['customerAccessTokenCreate'] == null) {
          //   print("Login attempt limit exceeded. Please try again later.");
          // }
        }
      } else if (result.data?['customerAccessTokenCreate']['customerUserErrors']
              [0]['code'] ==
          "UNIDENTIFIED_CUSTOMER") {
        createAlertDialog(context, "Email or Password in Invalid");
      } else if (result.data?['customerAccessTokenCreate'] == null) {
        createAlertDialog(
            context, 'Login attempt limit exceeded. Please try again later.');
      }
      // } else {
      //   print("Validate failed");
      // }
    } else {
      print("Validate failed");
    }
  }
}

// Create

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

class BlueCirclePainter extends CustomPainter {
  final Paint mainColor = Paint()..color = AppColors.primary;
  final Paint secondaryColor = Paint()..color = AppColors.secondary;
  final Paint secondaryLightColor = Paint()..color = AppColors.secondary_light;
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    final textStyle = TextStyle(
        color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold);
    final textSpan = TextSpan(
      text: 'Log In',
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
