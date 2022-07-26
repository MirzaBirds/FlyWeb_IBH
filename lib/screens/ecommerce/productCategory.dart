import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/config/productCollection.dart';
import 'package:doctor_dreams/screens/ecommerce/productList.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({Key? key}) : super(key: key);

  @override
  _ProductCategoryState createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppPrimaryBar(isSleetBelt: true),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "Mattress",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                  fontSize: 27.00),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ButtonTheme(
                                height: 20.0,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: AppColors.primary, width: 0.5),
                                  ),
                                  child: Text('Shop Now',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w300)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductList(
                                                categoryType: ProductCollection
                                                    .matters)));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          child: CircleAvatar(
                              radius: (70),
                              backgroundColor: AppColors.primary,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  "assets/mettress.png",
                                  fit: BoxFit.fill,
                                  width: 120,
                                  height: 120,
                                ),
                              ))),
                    ]),

                // bed
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: CircleAvatar(
                            radius: (70),
                            backgroundColor: AppColors.secondary,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/bed.png",
                                fit: BoxFit.fill,
                                width: 160,
                                height: 160,
                              ),
                            )),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "Bed",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                  fontSize: 27.00),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ButtonTheme(
                                height: 20.0,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: AppColors.primary, width: 0.5),
                                  ),
                                  child: Text('Shop Now',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w300)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductList(
                                                categoryType:
                                                    ProductCollection.beds)));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                // Pillows
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "Pillows",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                  fontSize: 27.00),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ButtonTheme(
                                height: 20.0,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: AppColors.primary, width: 0.5),
                                  ),
                                  child: Text('Shop Now',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w300)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductList(
                                                categoryType: ProductCollection
                                                    .pillows)));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: CircleAvatar(
                            radius: (70),
                            backgroundColor: AppColors.primary,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/pillows.png",
                                fit: BoxFit.fill,
                                width: 150,
                                height: 120,
                              ),
                            )),
                      ),
                    ]),
                // Blankets
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: CircleAvatar(
                            radius: (70),
                            backgroundColor: AppColors.secondary,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/blanket.png",
                                fit: BoxFit.fill,
                                width: 120,
                                height: 120,
                              ),
                            )),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "Bedding",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                  fontSize: 27.00),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ButtonTheme(
                                height: 20.0,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: AppColors.primary, width: 0.5),
                                  ),
                                  child: Text('Shop Now',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w300)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductList(
                                                categoryType: ProductCollection
                                                    .bedding)));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                // Pillows
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "Essentials",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                  fontSize: 27.00),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ButtonTheme(
                                height: 20.0,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: AppColors.primary, width: 0.5),
                                  ),
                                  child: Text('Shop Now',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w300)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductList(
                                                categoryType: ProductCollection
                                                    .essentials)));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: CircleAvatar(
                            radius: (70),
                            backgroundColor: AppColors.primary,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/aroma.png",
                                fit: BoxFit.fill,
                                width: 120,
                                height: 120,
                              ),
                            )),
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
