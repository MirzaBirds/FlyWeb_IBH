import 'dart:async';

import 'package:doctor_dreams/screens/hardware/sleep_belt/pairDeviceScreen.dart';
import 'package:doctor_dreams/screens/hardware/sleep_belt/userPersonalInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../../../config/appColors.dart';
import '../../../widgets/appBar.dart';
import '../../../widgets/bottomNav.dart';
import '../../../widgets/drawer.dart';
import '../../../widgets/topNav.dart';

class AccountManagementScreen extends StatefulWidget {
  final BluetoothDevice device;
  final List<BluetoothService> services;
  final Map<int, List<int>> readValues = new Map<int, List<int>>();
  AccountManagementScreen({Key? key, required this.device, required this.services}) : super(key: key);

  @override
  State<AccountManagementScreen> createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagementScreen> {
  List listTitle = [
    "Pair Device",
    "Battery Level",
    "User Personal Information"
  ];
  List listIcons = [
    Icons.perm_device_info,
    Icons.battery_charging_full_rounded,
    Icons.person,
  ];

  BluetoothService? tempservice;
  BluetoothCharacteristic? _nodifycharacteristic;
  BluetoothCharacteristic? _writecharacteristic;
  int comandKind = 0;
  late Timer timer;
  bool isConnected = false;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timer =  Timer.periodic(new Duration(seconds: 1), (timer) {
      FlutterBlue.instance.connectedDevices.then((value) {
        if (value.length >= 1 && !isConnected) {
          _notification();
          isConnected = true;
        } else if (value.length == 0 && isConnected) {
          isConnected = false;
        }
      });
    });

    this.getUserData();
  }


  getUserData() {
    timer =  Timer.periodic(new Duration(seconds: 2), (timer) {
      // comandKind = 0;
      if (isConnected) {
        _sendCommand();
      }
    });

    // Timer.periodic(new Duration(seconds: 7), (timer) {
    //   // comandKind = 0;
    //   if (isConnected) {
    //     _sendCommand();
    //     setState(() {
    //       // comandKind = 1;
    //       _writecharacteristic!.write(getRealTimeHeartRate());
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppPrimaryBar(isSleetBelt: true),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopNavBar(device: widget.device,
                services:
                widget.services,),
              SizedBox(
                height: 5,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Icon(
                    Icons.person,
                    size: 40,
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                "Abcd",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: AppColors.primary),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                itemCount: listTitle.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: InkWell(
                      onTap: () {
                        if (listTitle[index] == "Pair Device") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PairDeviceScreen()));
                        } else if (listTitle[index] == "Battery Level") {
                        } else if (listTitle[index] ==
                            "User Personal Information") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPersonalInfo(device: widget.device,services: widget.services,)));
                        }
                      },
                      child: Container(
                        color: AppColors.primary,
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(listIcons[index], color: AppColors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  listTitle[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: AppColors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: AppColors.primary),
                                ),
                                Icon(Icons.arrow_forward_ios_outlined,
                                    color: AppColors.white),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }

  Future<void> _notification() async {
    tempservice = widget.services[2];
    for (BluetoothCharacteristic characteristic
    in tempservice!.characteristics) {
      if (characteristic.properties.write)
        _writecharacteristic = characteristic;
      if (characteristic.properties.notify)
        _nodifycharacteristic = characteristic;
    }
    _nodifycharacteristic?.value.listen((value) {
      if (mounted)
        setState(() {
          switch (comandKind) {
            case 0:
              widget.readValues[0] = value;
              break;
          // case 1:
          //   widget.readValues[1] = value;
          //   break;
          // case 2:
          //   widget.readValues[2] = value;
          //   break;
          // case 3:
          //   widget.readValues[3] = value;
          //   break;
          // case 4:
          //   widget.readValues[4] = value;
          //   break;
          // case 5:
          //   widget.readValues[5] = value;
          //   break;
          // case 6:
          //   widget.readValues[6] = value;
          //   break;
          // case 7:
          //   widget.readValues[7] = value;
          //   break;
          }
        });
    });
    await _nodifycharacteristic?.setNotifyValue(true);
  }

  Future<void> _sendCommand() async {
    print("Device Connecting State value is $isConnected");

    comandKind++;
    if (comandKind == 1) comandKind = 0;
    print("+++++++++++++++++++comandKind++++++++++++++++++++++++++");
    print(comandKind);
    switch (comandKind) {
      case 0:
        await _writecharacteristic!.write(getHeartRateBreathing());
        break;
    // case 1:
    //   await _writecharacteristic!.write(getRealTimeHeartRate());
    //   break;
    /*case 2:
        await _writecharacteristic.write(_buildChargeBotCommand(1, 81));
        break;
      case 3:
        await _writecharacteristic.write(_buildChargeBotCommand(1, 82));
        break;
      case 4:
        await _writecharacteristic.write(_buildChargeBotCommand(1, 87));
        break;
      case 5:
        await _writecharacteristic.write(_buildChargeBotCommand(1, 88));
        break;
      case 6:
        await _writecharacteristic.write(_buildChargeBotCommand(1, 89));
        break;
      case 7:
        await _writecharacteristic.write(_buildChargeBotCommand(1, 93));
        break;*/
    }
  }

  List<int> getRealValueFromArray(List<int> data) {
    print("+++++++++++++++++++++++++++++");
    print(data);
    print("+++++++++++++++++++++++++++++");
    // if (data == null) return 0;
    // List<int> temp = <int>[];
    // temp = data;
    // if (temp == null) return 0;
    if (data.length == 0)
      return [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ];
    else {
      // return (temp[3] << 8) + temp[4];
      return data;
    }
    return data;
  }

  //
  static int _getBcdValue(int value) {
    String data = value.toString();
    if (data.length > 2) data = data.substring(2);
    return int.parse(data, radix: 16);
  }

  /// crc validation
  static void crcValue(List<int> list) {
    int crcValue = 0;
    for (final int value in list) {
      crcValue += value;
    }
    list[15] = crcValue & 0xff;
  }

  static List<int> generateValue(int size) {
    final List<int> value = List<int>.generate(size, (int index) {
      return 0;
    });
    return value;
  }

  static List<int> _generateInitValue() {
    return generateValue(16);
  }

  static List<int> _setPersonalInfo(int gender,int age,int height,int weight) {
    final List<int> value = _generateInitValue(); //16
    value[0] = 0x01;
    value[1] = _getBcdValue(gender);
    value[2] = _getBcdValue(age);
    value[3] = _getBcdValue(height);
    value[4] = _getBcdValue(weight);
    crcValue(value);
    return value;
  }

  static List<int> setDeviceTime() {
    final List<int> value = _generateInitValue(); //16
    final int year = DateTime.now().year;
    final int month = DateTime.now().month;
    final int day = DateTime.now().day;
    final int hour = DateTime.now().hour;
    final int minute =DateTime.now().minute;
    final int second = DateTime.now().second;
    value[0] = 0x01;
    value[1] = _getBcdValue(year);
    value[2] = _getBcdValue(month);
    value[3] = _getBcdValue(day);
    value[4] = _getBcdValue(hour);
    value[5] = _getBcdValue(minute);
    value[6] = _getBcdValue(second);
    crcValue(value);
    return value;
  }

  static List<int> getPowerDevice() {
    final List<int> value = _generateInitValue(); //16
    final int AA = 1;
    value[0] = 0xd;
    value[1] = _getBcdValue(AA);
    crcValue(value);
    return value;
  }

  static List<int> getHeartRateBreathing() {
    final List<int> value = _generateInitValue(); //16
    // final int AA = 1;
    value[0] = 0x17;
    // value[1] = _getBcdValue(AA);
    crcValue(value);
    return value;
  }
}
