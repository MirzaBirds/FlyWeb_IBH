import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/home.dart';
import 'package:doctor_dreams/screens/Auth/tuya/tuyaAuthScreen.dart';
import 'package:doctor_dreams/screens/hardware/pairDevice.dart';
import 'package:doctor_dreams/screens/hardware/productList.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:tuya_ui_bizbundle/tuya_ui_bizbundle.dart';

class PairDevice1 extends StatefulWidget {
  static const String id = 'pair_device1';

  const PairDevice1({Key? key}) : super(key: key);

  @override
  _PairDevice1State createState() => _PairDevice1State();
}

class _PairDevice1State extends State<PairDevice1> {
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
    //   // String? message = await TuyaUiBizbundle.getDeviceList();
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
      appBar: AppPrimaryBar(),
      drawer: AppDrawer(),
      body: Container(
          decoration: new BoxDecoration(color: AppColors.primary),
          child: myLayoutWidget(context, isLoggedIn, devices)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PairDevice()));
        },
        backgroundColor: AppColors.secondary,
        child: const Icon(Icons.add),
      ),
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
              const EdgeInsets.only(left: 30, top: 60, right: 0, bottom: 0),
          child: Text(
            "Your Devices",
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
              //       'Tap to Pair',
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //   ),
              // ),
              // isLoggedIn
              //     ? Container()
              //     : Column(
              //         children: [
              //           SizedBox(height: 5),
              //           Container(
              //             width: 150,
              //             padding: EdgeInsets.symmetric(vertical: 15),
              //             alignment: Alignment.center,
              //             decoration: BoxDecoration(
              //                 // borderRadius: BorderRadius.only(
              //                 //   topRight: Radius.circular(15),
              //                 //   bottomRight: Radius.circular(15),
              //                 //   topLeft: Radius.circular(15),
              //                 //   bottomLeft: Radius.circular(15),
              //                 // ),
              //                 color: AppColors.secondary),
              //             child: GestureDetector(
              //               onTap: () {
              //                 // print("button press");
              //                 Navigator.of(context).push(
              //                   MaterialPageRoute(
              //                       builder: (BuildContext context) =>
              //                           TuyaAuthScreen()),
              //                 );
              //               },
              //               child: Text(
              //                 'Connect a Device',
              //                 style:
              //                     TextStyle(fontSize: 18, color: Colors.white),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              // isLoggedIn
              //     ? Column(
              //         children: [
              //           SizedBox(height: 5),
              //           GestureDetector(
              //             onTap: () {
              //               // print("button press");
              //               TuyaUiBizbundle.devicePair();
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
              //                 // 'Pair Tuya Device',
              //                 'Pair Device',
              //                 style:
              //                     TextStyle(fontSize: 18, color: Colors.white),
              //               ),
              //             ),
              //           ),
              //         ],
              //       )
              //     : Container(),
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
              (devices.length == 0)
                  ? Padding(
                      padding: EdgeInsets.only(left: 32, right: 16, top: 8),
                      child: Text("You don't have any devices",
                          style: TextStyle(
                              fontSize: 15,
                              color: AppColors.white,
                              fontWeight: FontWeight.w400)),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          for (int i = 0; i < devices.length; i++)
                            DeviceButton(context, devices[i].deviceId,
                                devices[i].deviceName),
                          SizedBox(height: 5),
                        ],
                      ),
                    )
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
              onTap: () async {
                // print("button press");
                // String? message = await TuyaUiBizbundle.openDevicePanel(id);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              """1. Doctor Dreams has function in the requires you to always allow the device to access your location. 
The data is used in when location changes in Doctor Dreams, which can still run even if the application is not in use.\n2. The access will only be used in this service and the data will not be collected and stored."""),
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
