import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/home.dart';
import 'package:doctor_dreams/screens/hardware/productList.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PairDevice extends StatefulWidget {
  static const String id = 'pair_device';

  const PairDevice({Key? key}) : super(key: key);

  @override
  _PairDeviceState createState() => _PairDeviceState();
}

class _PairDeviceState extends State<PairDevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppPrimaryBar(),
      drawer: AppDrawer(),
      body: Container(
          decoration: new BoxDecoration(color: AppColors.primary),
          child: myLayoutWidget(context)),
      bottomNavigationBar: BottomNavBar(),
    );
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
            "Pair A \nDevice",
            style: TextStyle(
                fontSize: 75,
                color: AppColors.white,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, top: 20, right: 0, bottom: 0),
          child: GestureDetector(
            onTap: () {
              print("button press");
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => productList()),
              );
            },
            child: Container(
              width: 150,
              padding: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  color: AppColors.secondary),
              child: Text(
                'Tap to Pair',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
