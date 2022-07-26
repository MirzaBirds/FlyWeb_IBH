import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppPrimaryBar(isSleetBelt: true),
        drawer: AppDrawer(),
        body: Container(
            decoration: new BoxDecoration(color: AppColors.primary),
            child: myLayoutWidget(context)),
        bottomNavigationBar: BottomNavBar());
  }
}

Widget myLayoutWidget(BuildContext context) {
  return Column(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, top: 130, right: 0, bottom: 0),
          child: Text(
            "Wishlist",
            style: TextStyle(
                fontSize: 40,
                color: AppColors.white,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    ],
  );
}
