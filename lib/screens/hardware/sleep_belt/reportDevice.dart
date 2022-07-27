import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:math';

import '../../../config/appColors.dart';
import '../../../utils.dart';

class ReportDeviceScreen extends StatefulWidget {
  final Map<int, List<int>> readValues;

  ReportDeviceScreen({Key? key, required this.readValues}) : super(key: key);

  @override
  State<ReportDeviceScreen> createState() => _ReportDeviceScreenState();
}

class _ReportDeviceScreenState extends State<ReportDeviceScreen> {
  @override
  void initState() {
    super.initState();
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
    // return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text(
                  TimeUtils.dayFormat(DateTime.now()),
                  style: TextStyle(color: AppColors.primary, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: <Widget>[
                  Center(
                    child: CircularStepProgressIndicator(
                      totalSteps: 50,
                      currentStep: (widget.readValues[0] != null
                              ? getRealValueFromArray(widget.readValues[0]!)[3]
                              : 0 / 2)
                          .toInt(),
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.width / 1.5,
                      selectedColor: AppColors.primary,
                      unselectedColor: AppColors.secondary_light,
                      selectedStepSize: 5.0,
                      unselectedStepSize: 5.0,
                      roundedCap: (_, isSelected) => isSelected,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        widget.readValues[2] != null
                            ? "${getRealValueFromArray(widget.readValues[2]!)[2]} ${getRealValueFromArray(widget.readValues[2]!)[3]} ${getRealValueFromArray(widget.readValues[2]!)[4]} ${getRealValueFromArray(widget.readValues[2]!)[5]}"
                                .toString()
                            : "No Sleep Data",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: AppColors.primary),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 170,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        "Rest Time",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: AppColors.primary),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 190,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        "0h:0min",
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
                height: 20,
              ),
              const Divider(
                color: AppColors.primary,
                height: 2,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/sleep_belt/ic_heart_pulse.png",
                        color: AppColors.primary,
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Average\nHeart Rate\n\n0Time/min",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: AppColors.primary),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/sleep_belt/ic_lungs.png",
                        color: AppColors.primary,
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Average\nBreath Rate\n\n0Time/min",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: AppColors.primary),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/sleep_belt/ic_bed_time.png",
                        color: AppColors.primary,
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Fall\nAsleep Rate\n\n0min",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: AppColors.primary),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
