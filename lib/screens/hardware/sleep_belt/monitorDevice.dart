import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../config/appColors.dart';
import '../../../utils.dart';
import '../../../widgets/appBar.dart';
import '../../../widgets/bottomNav.dart';
import '../../../widgets/drawer.dart';
import '../../../widgets/topNav.dart';

class MonitorDeviceScreen extends StatefulWidget {
  MonitorDeviceScreen({required this.device, required this.services});

  final BluetoothDevice device;
  final List<BluetoothService> services;
  final Map<int, List<int>> readValues = new Map<int, List<int>>();

  @override
  State<MonitorDeviceScreen> createState() => _MonitorDeviceScreenState();
}

class _MonitorDeviceScreenState extends State<MonitorDeviceScreen> {
  BluetoothService? tempservice;
  BluetoothCharacteristic? _nodifycharacteristic;
  BluetoothCharacteristic? _writecharacteristic;
  int comandKind = 0;
  late Timer timer;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(new Duration(seconds: 1), (timer) {
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
    Timer.periodic(new Duration(seconds: 2), (timer) {
      // comandKind = 0;
      if (isConnected) {
        _sendCommand();
        setState(() {
          // comandKind = 0;
          _writecharacteristic!.write(getPowerDevice());
          _writecharacteristic!.write(getRealTimeHeartRate());
        });
      }
    });

    // Timer.periodic(new Duration(seconds: 5), (timer) {
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
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/sleep_belt/ic_thermometer.png",
                        color: AppColors.primary,
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        widget.readValues[0] != null
                            ? "${getRealValueFromArray(widget.readValues[0]!)[1]}°C"
                            : "--",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: AppColors.primary),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Image.asset(
                        "assets/sleep_belt/ic_water_drop.png",
                        color: AppColors.primary,
                        height: 30,
                        width: 25,
                      ),
                      Text(
                        widget.readValues[0] != null
                            ? "${getRealValueFromArray(widget.readValues[0]!)[3]}%"
                            : "--",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: AppColors.primary),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // Column(
                  //   children: [
                  //     Icon(
                  //       Icons.adjust_rounded,
                  //       color: AppColors.primary,
                  //       size: 30,
                  //     ),
                  //     Text(
                  //       widget.readValues[0] != null
                  //           ? getRealValueFromArray(widget.readValues[0]!)[3]
                  //               .toString()
                  //           : "-",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.normal,
                  //           fontSize: 20,
                  //           color: AppColors.primary),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircularStepProgressIndicator(
                            totalSteps: 20,
                            currentStep: (widget.readValues[1] != null
                                    ? getRealValueFromArray(
                                        widget.readValues[1]!)[1]
                                    : 0 / 5)
                                .toInt(),
                            width: 150,
                            height: 150,
                            selectedColor: AppColors.primary,
                            unselectedColor: AppColors.secondary_light,
                            selectedStepSize: 5.0,
                            unselectedStepSize: 5.0,
                            roundedCap: (_, isSelected) => isSelected,
                          ),
                          Positioned(
                            top: 30,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Image.asset(
                                "assets/sleep_belt/ic_heart_pulse.png",
                                color: AppColors.primary,
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 75,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                widget.readValues[1] != null
                                    ? "${getRealValueFromArray(widget.readValues[1]!)[1]}"
                                    : "--",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: AppColors.primary),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                "Time/Min",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: AppColors.primary),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Stack(
                        children: [
                          CircularStepProgressIndicator(
                            totalSteps: 20,
                            currentStep: (widget.readValues[1] != null
                                    ? getRealValueFromArray(
                                        widget.readValues[1]!)[2]
                                    : 0 / 5)
                                .toInt(),
                            width: 150,
                            height: 150,
                            selectedColor: AppColors.primary,
                            unselectedColor: AppColors.secondary_light,
                            selectedStepSize: 5.0,
                            unselectedStepSize: 5.0,
                            roundedCap: (_, isSelected) => isSelected,
                          ),
                          Positioned(
                            top: 30,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Image.asset(
                                "assets/sleep_belt/ic_lungs.png",
                                color: AppColors.primary,
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 75,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                widget.readValues[1] != null
                                    ? "${getRealValueFromArray(widget.readValues[1]!)[2]}"
                                    : "--",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: AppColors.primary),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                "Time/Min",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: AppColors.primary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Image.asset(
                "assets/sleep_belt/ic_sleeping_bed.png",
                height: MediaQuery.of(context).size.width / 1.6,
                width: MediaQuery.of(context).size.width,
              ),
              Text(
                "Check Real-Time Sleep Status Now!",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: AppColors.primary),
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
            case 1:
              widget.readValues[1] = value;
              break;
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
    if (comandKind == 2) comandKind = 0;
    print("+++++++++++++++++++comandKind++++++++++++++++++++++++++");
    print(comandKind);
    switch (comandKind) {
      case 0:
        await _writecharacteristic!.write(getPowerDevice());
        break;
      case 1:
        await _writecharacteristic!.write(getRealTimeHeartRate());
        break;
      // case 2:
      //   await _writecharacteristic!.write(getRealTimeHeartRate());
      //   break;
      /* case 3:
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

  List<int> _buildChargeBotCommand(int command1, int command2) {
    List<int> cmd = <int>[];
    cmd.add(170);
    cmd.add(command1);
    cmd.add(command2);
    cmd.add(0);
    cmd.add(0);
    return cmd;
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

  static List<int> setPersonalInfo() {
    final List<int> value = _generateInitValue(); //16
    final int year = 2022;
    final int month = 5;
    final int day = 20;
    final int hour = 00;
    final int minute = 00;
    final int second = 00;
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

  static List<int> setDeviceTime() {
    final List<int> value = _generateInitValue(); //16
    final int year = 2022;
    final int month = 5;
    final int day = 20;
    final int hour = 00;
    final int minute = 00;
    final int second = 00;
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

  static List<int> getRealTimeHeartRate() {
    final List<int> value = _generateInitValue(); //16
    final int AA = 1;
    value[0] = 0x11;
    value[1] = _getBcdValue(AA);
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

  static List<int> getPowerDevice1() {
    final List<int> value = _generateInitValue(); //16
    // final int AA = 1;
    value[0] = 0x13;
    // value[1] = _getBcdValue(AA);
    crcValue(value);
    return value;
  }
}
