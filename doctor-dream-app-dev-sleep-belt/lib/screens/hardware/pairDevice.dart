import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/home.dart';
import 'package:doctor_dreams/screens/Auth/tuya/tuyaAuthScreen.dart';
import 'package:doctor_dreams/screens/ecommerce/productList.dart';
import 'package:doctor_dreams/screens/hardware/findDevice.dart';
import 'package:doctor_dreams/screens/hardware/pairDevice1.dart';
import 'package:doctor_dreams/screens/hardware/productList.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tuya_ui_bizbundle/tuya_ui_bizbundle.dart';

class PairDevice extends StatefulWidget {
  static const String id = 'pair_device';

  const PairDevice({Key? key}) : super(key: key);

  @override
  _PairDeviceState createState() => _PairDeviceState();
}

class _PairDeviceState extends State<PairDevice> {
  bool isLoggedIn = false;
  List<Device> devices = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkTuyaDetails();
  }

  void checkTuyaDetails() async {
    print("checkTuya 1");
    // if (await TuyaUiBizbundle.isLoggedin()) {
    //   setState(() {
    //     this.isLoggedIn = true;
    //   });
    //   print("checkTuya 2");

    //   print("checkTuya 4");
    //   /*bool bluetoothStatus=await Permission.bluetooth.isGranted;
    //   print("blueTooth permission");
    //   print(bluetoothStatus);
    //   if(!bluetoothStatus){
    //     await Permission.bluetooth.request();
    //   }*/
    //   bool locationStatus = await Permission.location.isGranted;
    //   print("location Status");
    //   print(locationStatus);
    //   if (!locationStatus) {
    //     createAlertDialog1(context, "test");
    //     // await Permission.location.request();
    //   }
    //   /*bool blueToothIsOn=await FlutterBlue.instance.isOn;
    //   print("blueToothisOn");
    //   print(blueToothIsOn);
    //   if(!blueToothIsOn) {
    //     AppSettings.openBluetoothSettings();
    //   }*/
    //   String? message = await TuyaUiBizbundle.getDeviceList();
    //   print("checkTuya 3");
    //   if (message != null) {
    //     if (message.startsWith("success")) {
    //       String jsonString = message.replaceRange(0, 7, "");
    //       List jsonArray = jsonDecode(jsonString);
    //       List<Device> tmpDevices = [];
    //       for (int i = 0; i < jsonArray.length; i++) {
    //         tmpDevices.add(Device(jsonArray[i]['id'], jsonArray[i]['name']));
    //       }

    //       setState(() {
    //         devices = tmpDevices;
    //       });
    //     } else {
    //       print(message);
    //     }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppPrimaryBar(isSleetBelt: true),
      drawer: AppDrawer(),
      body: Container(
          decoration: new BoxDecoration(color: AppColors.primary),
          child: myLayoutWidget(context, isLoggedIn, devices)),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

Widget myLayoutWidget(
    BuildContext context, bool isLoggedIn, List<Device> devices) {
  return Column(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, top: 60, right: 0, bottom: 30),
          child: Text(
            "Pair a Device",
            style: TextStyle(
                fontSize: 40,
                color: AppColors.white,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 00, top: 20, right: 0, bottom: 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => productList()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(children: [
                            Text(
                              "Sleep Belt",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  color: AppColors.white),
                            ),
                          ]),
                          Column(children: [
                            Image.asset('assets/wa1.png',
                                height: 130.00, fit: BoxFit.fill),
                          ])
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 5),
              // GestureDetector(
              //   onTap: () {
              //     print("button press");
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //           builder: (BuildContext context) => productList()),
              //     );
              //   },
              //   child: Container(
              //     width: 150,
              //     padding: EdgeInsets.symmetric(vertical: 15),
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //         // borderRadius: BorderRadius.only(
              //         //   topRight: Radius.circular(15),
              //         //   bottomRight: Radius.circular(15),
              //         //   topLeft: Radius.circular(15),
              //         //   bottomLeft: Radius.circular(15),
              //         // ),
              //         color: AppColors.secondary),
              //     child: Text(
              //       // 'Tap to Pair',
              //       'Sleep Belt',
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //   ),
              // ),
              isLoggedIn
                  ? Container()
                  : Column(
                      children: [
                        // SizedBox(height: 5),
                        // Container(
                        //   width: 150,
                        //   padding: EdgeInsets.symmetric(vertical: 15),
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //       // borderRadius: BorderRadius.only(
                        //       //   topRight: Radius.circular(15),
                        //       //   bottomRight: Radius.circular(15),
                        //       //   topLeft: Radius.circular(15),
                        //       //   bottomLeft: Radius.circular(15),
                        //       // ),
                        //       color: AppColors.secondary),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       // print("button press");
                        //       Navigator.of(context).push(
                        //         MaterialPageRoute(
                        //             builder: (BuildContext context) =>
                        //                 TuyaAuthScreen()),
                        //       );
                        //     },
                        //     child: Text(
                        //       'Diffuser',
                        //       style:
                        //           TextStyle(fontSize: 18, color: Colors.white),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: AppColors.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 16, right: 16, top: 8),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             TuyaAuthScreen()));
                                  diffuserScreenAlert(context, "test");
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(children: [
                                      Text(
                                        "Aromatic \nDiffuser",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28,
                                            color: AppColors.white),
                                      ),
                                    ]),
                                    Column(children: [
                                      Image.asset('assets/difuuser.png',
                                          height: 130.00, fit: BoxFit.fill),
                                    ])
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              isLoggedIn
                  ? Column(
                      children: [
                        //     SizedBox(height: 5),
                        //     GestureDetector(
                        //       onTap: () {
                        //         // print("button press");
                        //         TuyaUiBizbundle.devicePair();
                        //       },
                        //       child: Container(
                        //         width: 150,
                        //         padding: EdgeInsets.symmetric(vertical: 15),
                        //         alignment: Alignment.center,
                        //         decoration: BoxDecoration(
                        //             // borderRadius: BorderRadius.only(
                        //             //   topRight: Radius.circular(15),
                        //             //   bottomRight: Radius.circular(15),
                        //             //   topLeft: Radius.circular(15),
                        //             //   bottomLeft: Radius.circular(15),
                        //             // ),
                        //             color: AppColors.secondary),
                        //         child: Text(
                        //           // 'Pair Tuya Device',
                        //           'Pair Device',
                        //           style:
                        //               TextStyle(fontSize: 18, color: Colors.white),
                        //         ),
                        //       ),
                        //     ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: AppColors.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 16, right: 16, top: 8),
                              child: GestureDetector(
                                onTap: () {
                                  afterLoginDiffuserScreenAlert(
                                      context, "test");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(children: [
                                      Text(
                                        "Pair Device",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28,
                                            color: AppColors.white),
                                      ),
                                    ]),
                                    Column(children: [
                                      Image.asset('assets/difuuser.png',
                                          height: 130.00, fit: BoxFit.fill),
                                    ])
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              // isLoggedIn
              //     ? Column(
              //         children: [
              //           SizedBox(height: 5),
              //           GestureDetector(
              //             onTap: () {
              //               // print("button press");
              //               TuyaUiBizbundle.openVoicePage();
              //             },
              //             child: Container(
              //               width: 150,
              //               padding: EdgeInsets.symmetric(vertical: 15),
              //               alignment: Alignment.center,
              //               decoration: BoxDecoration(
              //                   // borderRadius: BorderRadius.only(
              //                   //   topRight: Radius.circular(15),
              //                   //   bottomRight: Radius.circular(15),
              //                   //   topLeft: Radius.circular(15),
              //                   //   bottomLeft: Radius.circular(15),
              //                   // ),
              //                   color: AppColors.secondary),
              //               child: Text(
              //                 'Open Voice Page',
              //                 style:
              //                     TextStyle(fontSize: 18, color: Colors.white),
              //               ),
              //             ),
              //           ),
              //           // SizedBox(height: 5),
              //         ],
              //       )
              //     : Container(),
              // SingleChildScrollView(
              //   scrollDirection: Axis.vertical,
              //   child: Column(
              //     children: [
              //       for (int i = 0; i < devices.length; i++)
              //         DeviceButton(
              //             context, devices[i].deviceId, devices[i].deviceName),
              //       SizedBox(height: 5),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    ],
  );
}

Widget DeviceButton(BuildContext context, String id, String name) {
  // return Column(
  //   children: [

  //     GestureDetector(
  //       onTap: () async {
  //         print("button press");
  //         String? message = await TuyaUiBizbundle.openDevicePanel(id);
  //       },
  //       child: Container(
  //         width: 150,
  //         padding: EdgeInsets.symmetric(vertical: 15),
  //         alignment: Alignment.center,
  //         decoration: BoxDecoration(
  //             // borderRadius: BorderRadius.only(
  //             //   topRight: Radius.circular(15),
  //             //   bottomRight: Radius.circular(15),
  //             //   topLeft: Radius.circular(15),
  //             //   bottomLeft: Radius.circular(15),
  //             // ),
  //             color: AppColors.secondary),
  //         child: Text(
  //           name,
  //           style: TextStyle(fontSize: 18, color: Colors.white),
  //         ),
  //       ),
  //     ),
  //   ],
  // );
  return Column(
    children: [
      // SizedBox(height: 5),
      // GestureDetector(
      //   onTap: () async {
      //     // print("button press");
      //     String? message = await TuyaUiBizbundle.openDevicePanel(id);
      //   },
      //   child: Container(
      //     width: 150,
      //     padding: EdgeInsets.symmetric(vertical: 15),
      //     alignment: Alignment.center,
      //     decoration: BoxDecoration(
      //         // borderRadius: BorderRadius.only(
      //         //   topRight: Radius.circular(15),
      //         //   bottomRight: Radius.circular(15),
      //         //   topLeft: Radius.circular(15),
      //         //   bottomLeft: Radius.circular(15),
      //         // ),
      //         color: AppColors.secondary),
      //     child: Text(
      //       name,
      //       style: TextStyle(fontSize: 18, color: Colors.white),
      //     ),
      //   ),
      // ),
      // SizedBox(height: 5),
      Card(
        color: AppColors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
          child: GestureDetector(
            onTap: () async {
              // print("button press");
              String? message = await TuyaUiBizbundle.openDevicePanel(id);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: AppColors.white),
                  ),
                ]),
                // Column(children: [
                //   Image.asset('assets/difuuser.png',
                //       height: 130.00, fit: BoxFit.fill),
                // ])
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

class Device {
  String deviceName;
  String deviceId;
  Device(this.deviceId, this.deviceName);
}

createAlertDialog1(BuildContext context, msg) {
  print("in popup !! ");
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              """1. Doctor Dreams has function in the requires you to always allow the device to access your location. The data is used in when location changes in Doctor Dreams, which can still run even if the application is not in use.\n2. The access will only be used in this service and the data will not be collected and stored."""),
          actions: <Widget>[
            MaterialButton(
                elevation: 5.0,
                child: Text('Okay'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await Permission.location.request();
                })
          ],
        );
      });
}

diffuserScreenAlert(BuildContext context, msg) {
  print("in popup !! ");
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('''Step 1 - make your diffuser discoverable\n
Step 2 - diffuser name will appear on the page\n
Step 3 - connect with it and enjoy!!'''),
          actions: <Widget>[
            MaterialButton(
                elevation: 5.0,
                child: Text('Okay'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TuyaAuthScreen()));
                })
          ],
        );
      });
}

afterLoginDiffuserScreenAlert(BuildContext context, msg) {
  print("in popup !! ");
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('''Step 1 - make your diffuser discoverable\n
Step 2 - diffuser name will appear on the page\n
Step 3 - connect with it and enjoy!!'''),
          actions: <Widget>[
            MaterialButton(
                elevation: 5.0,
                child: Text('Okay'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  // TuyaUiBizbundle.devicePair();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PairDevice1(
                                isSleetbelt: true,
                              )));
                })
          ],
        );
      });
}
