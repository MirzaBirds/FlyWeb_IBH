import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../config/appColors.dart';
import '../../../utilities/ble.dart';
import '../../../utils.dart';

class MonitorDeviceScreen extends StatefulWidget {
  const MonitorDeviceScreen({Key? key}) : super(key: key);

  @override
  State<MonitorDeviceScreen> createState() => _MonitorDeviceScreenState();
}

class _MonitorDeviceScreenState extends State<MonitorDeviceScreen> {
  BLE ble = BLE();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log("Read Data ${ble.readData()}");
    // ble.sendData();
    // // log("Read Data ${ble.readData()}");
    // print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    // print("Read Data ${ble.readData()}");
    // print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    ble.sendData();
                  },
                  child: Text("send data")),
              ElevatedButton(
                  onPressed: () {
                    ble.readData();
                  },
                  child: Text("Read data")),
              ElevatedButton(
                  onPressed: () {
                    BLE ble = BLE();
                    ble.connectToBLE();
                  },
                  child: Text("Connect")),
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
                        "${ble.readData()}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
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
                        height: 25,
                        width: 25,
                      ),
                      Text(
                        "--",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            color: AppColors.primary),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.adjust_rounded,
                        color: AppColors.primary,
                        size: 30,
                      ),
                      Text(
                        "--",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            color: AppColors.primary),
                      ),
                    ],
                  ),
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
                            currentStep: (70 / 5).toInt(),
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
                                "--",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
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
                            currentStep: (70 / 5).toInt(),
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
                                "--",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
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
      ),
    );
  }
}
