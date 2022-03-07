import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ExperienceCenter extends StatefulWidget {
  const ExperienceCenter({Key? key}) : super(key: key);

  @override
  _ExperienceCenterState createState() => _ExperienceCenterState();
}

class _ExperienceCenterState extends State<ExperienceCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppPrimaryBar(),
        drawer: AppDrawer(),
        body: Container(child: myLayoutWidget(context)),
        bottomNavigationBar: BottomNavBar());
  }
}

Widget myLayoutWidget(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.only(left: 6, bottom: 6, top: 12),
                // color: Colors.red,
                child: Text(
                  "Dormant Dream",
                  style: TextStyle(
                    shadows: [
                      Shadow(color: AppColors.primary, offset: Offset(0, -5))
                    ],
                    fontSize: 20.00,
                    fontWeight: FontWeight.bold,
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationThickness: 3,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.only(left: 6, bottom: 12, top: 6),
                // color: Colors.red,
                child: Text(
                  "A harmony composed to slow the rate of your breathing and clear your mind",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 14.00),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
