import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/config/graphql.dart';
import 'package:doctor_dreams/config/logoSize.dart';
import 'package:doctor_dreams/services/shopify/customerAuth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Signup extends StatefulWidget {
  static const String id = 'singup_screen';

  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String conformPassword = '';
  bool isMobileValid = true;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final GraphQLClient _client = getGraphQLClient();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 30.00),
          height: MediaQuery.of(context).size.height * 1.25,
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
                  height: 275.0,
                  child: CustomPaint(
                    painter: BlueCirclePainter(),
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.only(left: 40, right: 35, top: 0),
                        // color: Colors.red,
                        child: Text(
                          "First Name",
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
                    initialValue: firstName,
                    onSaved: (val) => firstName = val.toString(),
                    validator: (val) => val.toString().length > 1
                        ? null
                        : 'First Name is invalid',
                    decoration: InputDecoration(
                      // labelText: 'Email',
                      hintText: 'Enter First Name',
                      // icon: Icon(Icons.phone),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.only(left: 40, right: 35, top: 16),
                        // color: Colors.red,
                        child: Text(
                          "Last Name",
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
                    initialValue: lastName,
                    onSaved: (val) => lastName = val.toString(),
                    validator: (val) => val.toString().length > 1
                        ? null
                        : 'Last Name is invalid',
                    decoration: InputDecoration(
                      // labelText: 'Email',
                      hintText: 'Enter Last Name',
                      // icon: Icon(Icons.phone),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
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
                    validator: (val) =>
                        val.toString().length > 10 ? null : 'Email is invalid',
                    decoration: InputDecoration(
                      // labelText: 'Email',
                      hintText: 'Enter Email',
                      // icon: Icon(Icons.phone),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
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
                    obscureText: !_passwordVisible,
                    initialValue: password,
                    onSaved: (val) => password = val.toString(),
                    validator: (val) => val.toString().length > 0
                        ? null
                        : 'Password can not be empty',
                    decoration: InputDecoration(
                      // labelText: 'Password',
                      hintText: 'Enter Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      // icon: Icon(Icons.password),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 40, right: 35, top: 16, bottom: 0),
                        // color: Colors.red,
                        child: Text(
                          "Confirm Password",
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
                    obscureText: !_confirmPasswordVisible,
                    initialValue: conformPassword,
                    onSaved: (val) => conformPassword = val.toString(),
                    validator: (val) => val.toString().length > 0
                        ? null
                        : 'Password can not be empty',
                    decoration: InputDecoration(
                      // labelText: 'Password',
                      hintText: 'Enter Password',
                      // icon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.00,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: signUp(context)),
                bottom_logo(),
              ],
            ),
          ),
        ),
      ),
    );
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

// Log In Button
  GestureDetector logIn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("LOGIN --> button press");

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => SignUpScreen()));
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

// Submit Button
  _submitSignup(BuildContext context) async {
    key.currentState?.save();
    if (key.currentState!.validate()) {
      print("form is validated");
      // Check password

      if (password == conformPassword) {
        print("password is correct !!");
        final MutationOptions options = MutationOptions(
          document: gql(CustomerAuth.customerSignUp),
          variables: <String, dynamic>{
            "email": email,
            "password": password,
            "firstName": firstName,
            "lastName": lastName
          },
        );

        final QueryResult result = await _client.mutate(options);
        print(result);
        if (result.hasException) {
          print(result.exception.toString());
          return;
        }

        if (result.data?['customerCreate']['customer'] != null) {
          print("account created successfully !! . Please check your email");
          createAlertDialog(context, 'Account Created Successfully !!');
          // Add dialogue box : message

          // reset form key
          key.currentState?.reset();
        } else if (result.data?['customerCreate']['customerUserErrors'][0]
                ['code'] ==
            "TAKEN") {
          print("in taken");
          // Add dialogue box : message
          print(result.data?['customerCreate']['customerUserErrors'][0]
              ['message']);

          createAlertDialog(
              context,
              result.data?['customerCreate']['customerUserErrors'][0]
                  ['message']);
        } else if (result.data?['customerCreate']['customerUserErrors'][0]
                ['code'] ==
            "INVALID") {
          // Add dialogue box : message
          print(result.data?['customerCreate']['customerUserErrors'][0]
              ['message']);
          createAlertDialog(
              context,
              result.data?['customerCreate']['customerUserErrors'][0]
                  ['message']);
        } else if (result.data?['customerCreate']['customerUserErrors'][0]
                ['code'] ==
            "PASSWORD_STARTS_OR_ENDS_WITH_WHITESPACE") {
          // Add dialogue box : message
          print(result.data?['customerCreate']['customerUserErrors'][0]
              ['message']);
          createAlertDialog(
              context,
              result.data?['customerCreate']['customerUserErrors'][0]
                  ['message']);
        } else if (result.data?['customerCreate']['customerUserErrors'][0]
                ['code'] ==
            "TOO_SHORT") {
          // Add dialogue box : message
          print(result.data?['customerCreate']['customerUserErrors'][0]
              ['message']);
          createAlertDialog(
              context,
              result.data?['customerCreate']['customerUserErrors'][0]
                  ['message']);
        } else if (result.data?['customerCreate'] == null) {
          print("Creating Customer Limit exceeded. Please try again later");
        }
      } else {
        print("password and confirm password must be same");
        // Create alert box and show error
        createAlertDialog(
            context, 'Password and confirm password must be same');
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
      text: 'Create\nAccount',
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
