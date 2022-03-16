import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/home.dart';
import 'package:doctor_dreams/screens/Auth/tuya/tuyaAuthScreen.dart';
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
  bool isLoggedIn=false;
  List<Device> devices=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkTuyaDetails();
  }
  void checkTuyaDetails() async{
    print("checkTuya 1");
    if(await TuyaUiBizbundle.isLoggedin()){
      setState(() {
        this.isLoggedIn=true;
      });
      print("checkTuya 2");

      print("checkTuya 4");
      bool bluetoothStatus=await Permission.bluetooth.isGranted;
      print("blueTooth permission");
      print(bluetoothStatus);
      if(!bluetoothStatus){
        await Permission.bluetooth.request();
      }
      bool locationStatus=await Permission.location.isGranted;
      print("location Status");
      print(locationStatus);
      if(!locationStatus){
        await Permission.location.request();
      }
      bool blueToothIsOn=await FlutterBlue.instance.isOn;
      print("blueToothisOn");
      print(blueToothIsOn);
      if(!blueToothIsOn) {
        AppSettings.openBluetoothSettings();
      }
      String? message=await TuyaUiBizbundle.getDeviceList();
      print("checkTuya 3");
      if(message!=null){
        if(message.startsWith("success")){
          String jsonString=message.replaceRange(0, 7, "");
          List jsonArray=jsonDecode(jsonString);
          List<Device> tmpDevices=[];
          for(int i=0;i<jsonArray.length;i++){
            tmpDevices.add(Device(jsonArray[i]['id'], jsonArray[i]['name']));
          }
          setState(() {
            devices=tmpDevices;
          });
        }else{
          print(message);
        }
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppPrimaryBar(),
      drawer: AppDrawer(),
      body: Container(
          decoration: new BoxDecoration(color: AppColors.primary),
          child: myLayoutWidget(context,isLoggedIn,devices)),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

Widget myLayoutWidget(BuildContext context,bool isLoggedIn,List<Device> devices) {
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
          child: Column(
            children: [
              GestureDetector(
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
              isLoggedIn?Container():GestureDetector(
                onTap: () {
                  print("button press");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => TuyaAuthScreen()),
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
                    'Login/Register with Tuya',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              isLoggedIn?GestureDetector(
                onTap: () {
                  print("button press");
                  TuyaUiBizbundle.devicePair();
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
                    'Pair Tuya Device',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ):Container(),
              SingleChildScrollView(scrollDirection: Axis.vertical,
              child: Row(children: [
                for(int i=0;i<devices.length;i++) DeviceButton(context, devices[i].deviceId, devices[i].deviceName)
              ],),)
            ],
          ),
        ),
      ),
    ],
  );
}

Widget DeviceButton(BuildContext context,String id, String name){
  return GestureDetector(
    onTap: () {
      print("button press");

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
        name,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    ),
  );
}

class Device{
  String deviceName;
  String deviceId;
  Device(this.deviceId,this.deviceName);
}
