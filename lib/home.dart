import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/screens/ecommerce/ProductDetail.dart';
import 'package:doctor_dreams/screens/ecommerce/productCategory.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const String id = 'home_screen';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppPrimaryBar(),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(left: 25, right: 25, top: 25),
            child: Column(children: <Widget>[
              Card(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      // leading: Icon(Icons.album),
                      title: Text(
                        'Yesterday\'s Sleep Cycle',
                        style: TextStyle(
                            fontSize: 20.00, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Total sleep: 7 hours',
                        style: TextStyle(
                            fontSize: 18.00, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/Vector.png')),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.only(left: 6, bottom: 12, top: 12),
                      // color: Colors.red,
                      child: Text(
                        "More Devices",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 18.00),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                color: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Aromic \nDiffuser",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: AppColors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Image.asset('assets/difuuser.png',
                                height: 130.00, fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.only(left: 6, bottom: 12, top: 12),
                      // color: Colors.red,
                      child: Text(
                        "Featured",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 18.00),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                color: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 10, top: 8, right: 0, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            "Comfortable \nMatters",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: AppColors.white),
                          ),
                          Text(
                            "perfect for peaceful sleep",
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 12,
                                color: AppColors.white),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ButtonTheme(
                              height: 30.0,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Colors.white, width: 0.5),
                                ),
                                child: Text('Explore',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductCategory()));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Image.asset('assets/bed.png',
                                height: 130.00, fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.only(left: 6, bottom: 12, top: 12),
                      // color: Colors.red,
                      child: Text(
                        "Deals for you",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 18.00),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                color: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    image: DecorationImage(
                      image: AssetImage("assets/card-bg.png"),
                      fit: BoxFit.fitWidth,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.dstATop),
                      alignment: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: [
                            Text(
                              "UPTO 60% OFF",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: AppColors.white),
                            ),
                            Text(
                              "On Pillows",
                              style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12,
                                  color: AppColors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.only(left: 6, bottom: 12, top: 12),
                      // color: Colors.red,
                      child: Text(
                        "Wellness",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 18.00),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                color: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "SNOOZE \nZONE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: AppColors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 0, top: 10),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Image.asset('assets/clock.png',
                                height: 200.00, fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.only(left: 6, bottom: 12, top: 12),
                      // color: Colors.red,
                      child: Text(
                        "Best Sellers",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 18.00),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                color: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 10, top: 8, right: 0, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            "Comfortable \nMatters",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: AppColors.white),
                          ),
                          Text(
                            "perfect for peaceful sleep",
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 12,
                                color: AppColors.white),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ButtonTheme(
                              height: 30.0,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Colors.white, width: 0.5),
                                ),
                                child: Text('Explore',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Image.asset('assets/bed.png',
                                height: 130.00, fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.only(left: 6, bottom: 12, top: 12),
                      // color: Colors.red,
                      child: Text(
                        "New",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 18.00),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                color: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 10, top: 8, right: 0, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            "Comfortable \nMatters",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: AppColors.white),
                          ),
                          Text(
                            "perfect for peaceful sleep",
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 12,
                                color: AppColors.white),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ButtonTheme(
                              height: 30.0,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Colors.white, width: 0.5),
                                ),
                                child: Text('Explore',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Image.asset('assets/bed.png',
                                height: 130.00, fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ])),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
