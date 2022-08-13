import 'dart:convert';

import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/screens/ecommerce/user-details/addAddress.dart';
import 'package:doctor_dreams/services/shopify/customerAuth.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var myProfile = {};

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    String getUserInfo = await CustomerAuth().getUserData();
    print("++++++++++++++++++++++user Data++++++++++++++++++++");

    setState(() {
      myProfile = json.decode(getUserInfo);
    });
    print(myProfile);
    print(json.decode(getUserInfo).runtimeType);
    print("++++++++++++++++++++++user Data++++++++++++++++++++");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppPrimaryBar(isSleetBelt: true),
        drawer: AppDrawer(),
        body: Container(
            decoration: new BoxDecoration(color: AppColors.primary),
            child: myLayoutWidget(context, myProfile)),
        bottomNavigationBar: BottomNavBar());
  }
}

Widget myLayoutWidget(BuildContext context, myProfile) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
    Text(
      "Profile Details",
      style: TextStyle(fontSize: 25.00, color: Colors.white),
    ),
    SizedBox(
      height: 20,
    ),
    GestureDetector(
      child: Card(
          margin: EdgeInsets.symmetric(vertical: 10.00, horizontal: 25.00),
          child: ListTile(
            leading: Icon(Icons.person, color: Colors.teal),
            title: Text(
              "${myProfile['firstName']} ${myProfile['lastName']}",
              style: TextStyle(
                  fontSize: 20.00,
                  fontFamily: 'Source Sans Pro',
                  color: Colors.teal.shade900),
            ),
          )),
      // onTap: () {
      //   launch("tel://9112285818");
      // },
    ),
    GestureDetector(
      child: Card(
          margin: EdgeInsets.symmetric(vertical: 10.00, horizontal: 25.00),
          child: ListTile(
            leading: Icon(Icons.email, color: Colors.teal),
            title: Text(
              "${myProfile['email']}",
              style: TextStyle(
                  fontSize: 20.00,
                  fontFamily: 'Source Sans Pro',
                  color: Colors.teal.shade900),
            ),
          )),
      // onTap: () {
      //   launch("tel://7020699909");
      // },
    ),
    // GestureDetector(
    //   child: Card(
    //       margin: EdgeInsets.symmetric(vertical: 10.00, horizontal: 25.00),
    //       child: ListTile(
    //         leading: Icon(Icons.pin_drop, color: Colors.teal),
    //         title: Text(
    //           myProfile['defaultAddress'] != null
    //               ? "${myProfile['defaultAddress']}"
    //               : "Address not found",
    //           style: TextStyle(
    //               fontSize: 20.00,
    //               fontFamily: 'Source Sans Pro',
    //               color: Colors.teal.shade900),
    //         ),
    //       )),
    //   // onTap: () {
    //   //   launch("tel://7020699909");
    //   // },
    // ),
    // SizedBox(height: 50),
    // GestureDetector(
    //   child: Card(
    //       margin: EdgeInsets.symmetric(vertical: 10.00, horizontal: 25.00),
    //       child: ListTile(
    //         leading: Icon(Icons.add, color: Colors.teal),
    //         title: Text(
    //           "Add new address",
    //           style: TextStyle(
    //               fontSize: 20.00,
    //               fontFamily: 'Source Sans Pro',
    //               color: Colors.teal.shade900),
    //         ),
    //       )),
    //   onTap: () {
    //     print("Add new address");
    //     Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => AddAddress()));
    //   },
    // ),
  ]);
}
