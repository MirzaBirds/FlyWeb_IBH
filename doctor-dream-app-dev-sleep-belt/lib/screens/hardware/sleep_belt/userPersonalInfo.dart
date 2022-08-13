import 'dart:async';

import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/utilities/my_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class UserPersonalInfo extends StatefulWidget {
  final BluetoothDevice device;
  final List<BluetoothService> services;
  final Map<int, List<int>> readValues = new Map<int, List<int>>();

  UserPersonalInfo({Key? key, required this.device, required this.services}) : super(key: key);

  @override
  State<UserPersonalInfo> createState() => _UserPersonalInfoState();
}

class _UserPersonalInfoState extends State<UserPersonalInfo> {
  String _selectedGenderValue = "Select Gender";
  String _selectedHeightValue = "Select Height";
  String _selectedWeightValue = "Select Weight";
  String _selectedBirthdayValue = "Select DD-MM-YYYY";

  int gender = 0;
  int age = 0;
  int height = 0;
  int weight = 0;

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

  _getValues() async {
    if (await MyPreference.getStringToSF(MyPreference.gender) != null) {
      _selectedGenderValue =
          await MyPreference.getStringToSF(MyPreference.gender);
    }
    if (await MyPreference.getStringToSF(MyPreference.height) != null) {
      _selectedHeightValue =
          await MyPreference.getStringToSF(MyPreference.height);
    }
    if (await MyPreference.getStringToSF(MyPreference.weight) != null) {
      _selectedWeightValue =
          await MyPreference.getStringToSF(MyPreference.weight);
    }
    if (await MyPreference.getStringToSF(MyPreference.birthday) != null) {
      _selectedBirthdayValue =
          await MyPreference.getStringToSF(MyPreference.birthday);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.primary),
        titleTextStyle: TextStyle(color: AppColors.primary),
        title: Text(
          "User Personal Information",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: InkWell(
              onTap: () {
                showPicker("Gender", [
                  Text(
                    "Female",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: AppColors.primary),
                  ),
                  Text(
                    "Male",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: AppColors.primary),
                  ),
                ]);
              },
              child: Container(
                color: AppColors.primary,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Gender",
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
                          _selectedGenderValue,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: AppColors.white),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,
                            color: AppColors.white),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: InkWell(
              onTap: () {
                List<Widget> list = [];
                for (int i = 30; i < 231; i++) {
                  list.add(Text(
                    "${i} cm",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: AppColors.primary),
                  ));
                }
                showPicker("Height", list);
              },
              child: Container(
                color: AppColors.primary,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Height",
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
                          _selectedHeightValue,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: AppColors.white),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,
                            color: AppColors.white),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: InkWell(
              onTap: () {
                List<Widget> list = [];
                for (int i = 3; i < 220; i++) {
                  list.add(Text(
                    "${i} kg",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: AppColors.primary),
                  ));
                }
                showPicker("Weight", list);
              },
              child: Container(
                color: AppColors.primary,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Weight",
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
                          _selectedWeightValue,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: AppColors.white),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,
                            color: AppColors.white),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: InkWell(
              onTap: () {
                List<Widget> list = [];
                for (int i = 10; i < 110; i++) {
                  list.add(Text(
                    "${i}",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: AppColors.primary),
                  ));
                }
                showPicker("age", list);
              },
              child: Container(
                color: AppColors.primary,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Birthday",
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
                          _selectedBirthdayValue,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: AppColors.white),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,
                            color: AppColors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Visibility(
            visible: true,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.secondary,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              ),
              onPressed: () {
                comandKind = 1;
                _writecharacteristic!.write(_setPersonalInfo(gender, age, height, weight));
              },
              child: Text(
                "Save",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: AppColors.white),
              ),
            ),
          )
        ],
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
      await _writecharacteristic!.write(_getPersonalInfo());
      break;
    }
  }

  List<int> getRealValueFromArray(List<int> data) {
    print("+++++++++++++++++++++++++++++");
    print(data);
    print("+++++++++++++++++++++++++++++");
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
      return data;
    }
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

  static List<int> getPowerDevice() {
    final List<int> value = _generateInitValue(); //16
    final int AA = 1;
    value[0] = 0xd;
    value[1] = _getBcdValue(AA);
    crcValue(value);
    return value;
  }

  static List<int> _getPersonalInfo() {
    final List<int> value = _generateInitValue(); //16
    value[0] = 0x42;
    crcValue(value);
    return value;
  }

  showPicker(String titleValue, List<Widget> widgetList) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: Column(
              children: [
                Container(
                  color: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            color: AppColors.primary,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Flexible(
                        child: Text(
                          "Gender",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.primary),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.done,
                            color: AppColors.primary,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 32,
                    scrollController:
                        FixedExtentScrollController(initialItem: 0),
                    children: widgetList,
                    onSelectedItemChanged: (value) {
                      setState(() {
                        print(value);
                        if (titleValue == "Gender") {
                          if (value == 0) {
                            MyPreference.addStringToSF(
                                MyPreference.gender, "Female");
                            _selectedGenderValue = "Female";
                            gender = 0;
                          } else {
                            MyPreference.addStringToSF(
                                MyPreference.gender, "Male");
                            _selectedGenderValue = "Male";
                            gender = 1;
                          }
                        } else if (titleValue == "Height") {
                          MyPreference.addStringToSF(
                              MyPreference.height, "${value + 30} cm");
                          _selectedHeightValue = "${value + 30} cm";
                          height = value + 30;
                        } else if (titleValue == "Weight") {
                          MyPreference.addStringToSF(
                              MyPreference.weight, "${value + 3} kg");
                          _selectedWeightValue = "${value + 3} kg";
                          weight = value + 3;
                        }else if (titleValue == "age") {
                          MyPreference.addStringToSF(
                              MyPreference.birthday, "${value + 10}");
                          _selectedBirthdayValue = "${value + 10}";
                          age = value + 10;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  showPickerDate() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            child: Column(
              children: [
                Container(
                  color: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            color: AppColors.primary,
                          ),
                          onPressed: () {}),
                      Flexible(
                        child: Text(
                          "Gender",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.primary),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.done,
                            color: AppColors.primary,
                          ),
                          onPressed: () {
                            //Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 200,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: AppColors.primary),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime(1969, 1, 1),
                        onDateTimeChanged: (DateTime newDateTime) {
                          // Do something
                          setState((){
                            _selectedBirthdayValue = "${newDateTime.day}-${newDateTime.month}-${newDateTime.year}";
                          });
                          MyPreference.addStringToSF(
                              MyPreference.birthday, "${newDateTime.day}-${newDateTime.month}-${newDateTime.year}");
                          print(newDateTime);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }


}
