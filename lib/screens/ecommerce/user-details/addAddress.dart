import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/config/graphql.dart';
import 'package:doctor_dreams/services/shopify/customerAuth.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
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
        appBar: AppPrimaryBar(),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 10.00, top: 25.00),
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          padding: EdgeInsets.only(left: 40, right: 35, top: 0),
                          // color: Colors.red,
                          child: Text(
                            "Address 1",
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
                      maxLines: 3,
                      initialValue: firstName,
                      onSaved: (val) => firstName = val.toString(),
                      validator: (val) => val.toString().length > 1
                          ? null
                          : 'Address 1 is invalid',
                      decoration: InputDecoration(
                        // labelText: 'Email',
                        hintText: 'Enter Address 1',
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
                          padding:
                              EdgeInsets.only(left: 40, right: 35, top: 16),
                          // color: Colors.red,
                          child: Text(
                            "Country",
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
                          : 'Country is invalid',
                      decoration: InputDecoration(
                        // labelText: 'Email',
                        hintText: 'Enter Country',
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
                          padding:
                              EdgeInsets.only(left: 40, right: 35, top: 16),
                          // color: Colors.red,
                          child: Text(
                            "Province",
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
                      validator: (val) => val.toString().length > 10
                          ? null
                          : 'Province is invalid',
                      decoration: InputDecoration(
                        // labelText: 'Email',
                        hintText: 'Enter Province',
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
                            "city",
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
                      initialValue: password,
                      onSaved: (val) => password = val.toString(),
                      validator: (val) => val.toString().length > 0
                          ? null
                          : 'city can not be empty',
                      decoration: InputDecoration(
                        // labelText: 'Password',
                        hintText: 'Enter Password',
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
                            "zip",
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
                      initialValue: conformPassword,
                      onSaved: (val) => conformPassword = val.toString(),
                      validator: (val) =>
                          val.toString().length > 0 ? null : 'zip not be empty',
                      decoration: InputDecoration(
                        // labelText: 'Password',
                        hintText: 'zip',
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

                  SizedBox(
                    height: 20.00,
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
        bottomNavigationBar: BottomNavBar());
  }

// Top Section Custom shapes
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
          'Add',
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

  _submitSignup(BuildContext context) async {
    key.currentState?.save();
    if (key.currentState!.validate()) {
      print("form is validated");
      // Check password
      print("In add Address");
      // if (password == conformPassword) {
      //   print("password is correct !!");
      //   final MutationOptions options = MutationOptions(
      //     document: gql(CustomerAuth.customerSignUp),
      //     variables: <String, dynamic>{
      //       "email": email,
      //       "password": password,
      //       "firstName": firstName,
      //       "lastName": lastName
      //     },
      //   );

      //   final QueryResult result = await _client.mutate(options);
      //   print(result.exception);
      //   if (result.hasException) {
      //     print(result.exception.toString());
      //     return;
      //   }

      //   if (result.data?['customerCreate']['customer'] != null) {
      //     print("account created successfully !! . Please check your email");
      //     // Add dialogue box : message
      //     // reset form key
      //     key.currentState?.reset();
      //   } else if (result.data?['customerCreate']['customerUserErrors'][0]
      //           ['code'] ==
      //       "TAKEN") {
      //     // Add dialogue box : message
      //     print(result.data?['customerCreate']['customerUserErrors'][0]
      //         ['message']);
      //   } else if (result.data?['customerCreate']['customerUserErrors'][0]
      //           ['code'] ==
      //       "INVALID") {
      //     // Add dialogue box : message
      //     print(result.data?['customerCreate']['customerUserErrors'][0]
      //         ['message']);
      //   } else if (result.data?['customerCreate']['customerUserErrors'][0]
      //           ['code'] ==
      //       "PASSWORD_STARTS_OR_ENDS_WITH_WHITESPACE") {
      //     // Add dialogue box : message
      //     print(result.data?['customerCreate']['customerUserErrors'][0]
      //         ['message']);
      //   }
      // } else {
      //   print("password and confirm password must be same");
      //   // Create alert box and show error
      // }
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
