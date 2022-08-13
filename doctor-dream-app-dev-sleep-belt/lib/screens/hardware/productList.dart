import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/screens/ecommerce/ProductDetailWebView.dart';
import 'package:doctor_dreams/screens/hardware/findDevice.dart';
import 'package:doctor_dreams/screens/hardware/sleep_belt/pairDeviceScreen.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';

class productList extends StatefulWidget {
  static const String id = 'productList';

  const productList({Key? key}) : super(key: key);

  @override
  _productListState createState() => _productListState();
}

class _productListState extends State<productList> {
  bool comming_soon = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppPrimaryBar(isSleetBelt: true),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: comming_soon
            ? Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 60, right: 0, bottom: 0),
                child: Text(
                  "Comming Soon",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              )
            : Container(
                padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                child: Column(children: <Widget>[
                  Container(
                    height: 150,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) => PairDeviceScreen()),
                        );
                      },
                      child: Card(
                        color: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        // elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 10, top: 40, right: 0, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Text(
                                      "Pair a Device",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27,
                                          color: AppColors.white),
                                    ),
                                    Text(
                                      "Tap to Pair",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15,
                                          color: AppColors.white),
                                    ),
                                    // Align(
                                    //   alignment: Alignment.centerLeft,
                                    //   child: Text(
                                    //     "Tap to Pair",
                                    //     style: TextStyle(
                                    //         fontWeight: FontWeight.w400,
                                    //         fontSize: 15,
                                    //         color: AppColors.white),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    child: Image.asset('assets/watcg.png',
                                        height: 65.00, fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                              EdgeInsets.only(left: 6, bottom: 12, top: 12),
                          // color: Colors.red,
                          child: Text(
                            "Products",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontSize: 20.00),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomScrollView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    slivers: <Widget>[
                      SliverPadding(
                        padding: const EdgeInsets.all(7),
                        sliver: SliverGrid.count(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.40),
                          children: <Widget>[
                            Container(
                              height: 300,
                              child: Card(
                                color: AppColors.secondary,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 4, right: 4, top: 8),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Diffuser",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Image.asset(
                                          'assets/difuuser.png',
                                          height: 130.00,
                                        ),
                                        // Text(
                                        //   "Rs. 3000 | rating",
                                        //   style: TextStyle(
                                        //       color: Colors.white,
                                        //       fontSize: 16,
                                        //       fontWeight: FontWeight.w100),
                                        // ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              // Icon(Icons.favorite_outline_outlined,
                                              //     color: AppColors.white),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 10,
                                                          right: 0,
                                                          bottom: 0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      print("button press");
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                ProductDetailWebView(
                                                                    handle:
                                                                        'doctor-dreams-by-nilkamal-bluetooth-enabled-aroma-diffuser-with-humidifier-mdodrarhudfrwht')),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 6),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color: AppColors
                                                              .primary),
                                                      child: Text(
                                                        'Buy',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                            // Container(
                            //   height: 300,
                            //   child: Card(
                            //     color: AppColors.secondary,
                            //     child: Padding(
                            //       padding:
                            //           EdgeInsets.only(left: 4, right: 4, top: 8),
                            //       child: Column(
                            //           mainAxisAlignment: MainAxisAlignment.start,
                            //           children: <Widget>[
                            //             Text(
                            //               "Sleep Belt",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.w100),
                            //             ),
                            //             Image.asset(
                            //               'assets/wa1.png',
                            //               height: 130.00,
                            //             ),
                            //             Text(
                            //               "Rs. 3000 | rating",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.w100),
                            //             ),
                            //             Padding(
                            //               padding: EdgeInsets.only(
                            //                   left: 10, right: 10, top: 0),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.end,
                            //                 children: <Widget>[
                            //                   Icon(Icons.favorite_outline_outlined,
                            //                       color: AppColors.white),
                            //                   Align(
                            //                     alignment: Alignment.bottomRight,
                            //                     child: Padding(
                            //                       padding: const EdgeInsets.only(
                            //                           left: 10,
                            //                           top: 10,
                            //                           right: 0,
                            //                           bottom: 0),
                            //                       child: GestureDetector(
                            //                         onTap: () {
                            //                           print("button press");
                            //                           Navigator.of(context).push(
                            //                             MaterialPageRoute(
                            //                                 builder: (BuildContext
                            //                                         context) =>
                            //                                     productList()),
                            //                           );
                            //                         },
                            //                         child: Container(
                            //                           width: 80,
                            //                           padding: EdgeInsets.symmetric(
                            //                               vertical: 5,
                            //                               horizontal: 6),
                            //                           alignment: Alignment.center,
                            //                           decoration: BoxDecoration(
                            //                               borderRadius:
                            //                                   BorderRadius.circular(
                            //                                       5.0),
                            //                               color: AppColors.primary),
                            //                           child: Text(
                            //                             'Buy',
                            //                             style: TextStyle(
                            //                                 fontSize: 14,
                            //                                 color: Colors.white),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ]),
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   height: 300,
                            //   child: Card(
                            //     color: AppColors.secondary,
                            //     child: Padding(
                            //       padding:
                            //           EdgeInsets.only(left: 4, right: 4, top: 8),
                            //       child: Column(
                            //           mainAxisAlignment: MainAxisAlignment.start,
                            //           children: <Widget>[
                            //             Text(
                            //               "Sleep Belt",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.w100),
                            //             ),
                            //             Image.asset(
                            //               'assets/wa1.png',
                            //               height: 130.00,
                            //             ),
                            //             Text(
                            //               "Rs. 3000 | rating",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.w100),
                            //             ),
                            //             Padding(
                            //               padding: EdgeInsets.only(
                            //                   left: 10, right: 10, top: 0),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.end,
                            //                 children: <Widget>[
                            //                   Icon(Icons.favorite_outline_outlined,
                            //                       color: AppColors.white),
                            //                   Align(
                            //                     alignment: Alignment.bottomRight,
                            //                     child: Padding(
                            //                       padding: const EdgeInsets.only(
                            //                           left: 10,
                            //                           top: 10,
                            //                           right: 0,
                            //                           bottom: 0),
                            //                       child: GestureDetector(
                            //                         onTap: () {
                            //                           print("button press");
                            //                           Navigator.of(context).push(
                            //                             MaterialPageRoute(
                            //                                 builder: (BuildContext
                            //                                         context) =>
                            //                                     productList()),
                            //                           );
                            //                         },
                            //                         child: Container(
                            //                           width: 80,
                            //                           padding: EdgeInsets.symmetric(
                            //                               vertical: 5,
                            //                               horizontal: 6),
                            //                           alignment: Alignment.center,
                            //                           decoration: BoxDecoration(
                            //                               borderRadius:
                            //                                   BorderRadius.circular(
                            //                                       5.0),
                            //                               color: AppColors.primary),
                            //                           child: Text(
                            //                             'Buy',
                            //                             style: TextStyle(
                            //                                 fontSize: 14,
                            //                                 color: Colors.white),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ]),
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   height: 300,
                            //   child: Card(
                            //     color: AppColors.secondary,
                            //     child: Padding(
                            //       padding:
                            //           EdgeInsets.only(left: 4, right: 4, top: 8),
                            //       child: Column(
                            //           mainAxisAlignment: MainAxisAlignment.start,
                            //           children: <Widget>[
                            //             Text(
                            //               "Sleep Belt",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.w100),
                            //             ),
                            //             Image.asset(
                            //               'assets/wa1.png',
                            //               height: 130.00,
                            //             ),
                            //             Text(
                            //               "Rs. 3000 | rating",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.w100),
                            //             ),
                            //             Padding(
                            //               padding: EdgeInsets.only(
                            //                   left: 10, right: 10, top: 0),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.end,
                            //                 children: <Widget>[
                            //                   Icon(Icons.favorite_outline_outlined,
                            //                       color: AppColors.white),
                            //                   Align(
                            //                     alignment: Alignment.bottomRight,
                            //                     child: Padding(
                            //                       padding: const EdgeInsets.only(
                            //                           left: 10,
                            //                           top: 10,
                            //                           right: 0,
                            //                           bottom: 0),
                            //                       child: GestureDetector(
                            //                         onTap: () {
                            //                           print("button press");
                            //                           Navigator.of(context).push(
                            //                             MaterialPageRoute(
                            //                                 builder: (BuildContext
                            //                                         context) =>
                            //                                     productList()),
                            //                           );
                            //                         },
                            //                         child: Container(
                            //                           width: 80,
                            //                           padding: EdgeInsets.symmetric(
                            //                               vertical: 5,
                            //                               horizontal: 6),
                            //                           alignment: Alignment.center,
                            //                           decoration: BoxDecoration(
                            //                               borderRadius:
                            //                                   BorderRadius.circular(
                            //                                       5.0),
                            //                               color: AppColors.primary),
                            //                           child: Text(
                            //                             'Buy',
                            //                             style: TextStyle(
                            //                                 fontSize: 14,
                            //                                 color: Colors.white),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ]),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ])),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
