import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class YourDevicesScreen extends StatefulWidget {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  final Map<int, List<int>> readValues = new Map<int, List<int>>();

  @override
  _YourDevicesScreenState createState() => _YourDevicesScreenState();
}

class _YourDevicesScreenState extends State<YourDevicesScreen> {
  final _writeController = TextEditingController();
  BluetoothDevice? _connectedDevice;
  List<BluetoothService>? _services;
  BluetoothService? tempservice;
  BluetoothCharacteristic? _nodifycharacteristic, _writecharacteristic;
  int comandKind = 0;

  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    widget.flutterBlue.startScan();
  }

  ListView _buildListViewOfDevices() {
    List<Container> containers = <Container>[];
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name),
                    Text(device.id.toString()),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.blue,
                child: Text(
                  'Connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await device.disconnect();
                  widget.flutterBlue.stopScan();
                  try {
                    await device.connect();
                  } catch (e) {
                    if (e != 'already_connected') {
                      throw e;
                    }
                  } finally {
                    _services = await device.discoverServices();
                  }
                  setState(() {
                    _connectedDevice = device;
                  });
                },
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  List<ButtonTheme> _buildReadWriteNotifyButton(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = <ButtonTheme>[];

    if (characteristic.properties.read) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: RaisedButton(
              color: Colors.blue,
              child: Text('READ', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                var sub = characteristic.value.listen((value) {
                  setState(() {
                    //widget.readValues[characteristic.uuid] = value;
                  });
                });
                await characteristic.read();
                sub.cancel();
              },
            ),
          ),
        ),
      );
    }
    if (characteristic.properties.write) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: RaisedButton(
              child: Text('WRITE', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Write"),
                        content: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: _writeController,
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Send"),
                            onPressed: () {
                              characteristic.write(
                                  utf8.encode(_writeController.value.text));
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
        ),
      );
    }
    if (characteristic.properties.notify) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: RaisedButton(
              child: Text('NOTIFY', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                characteristic.value.listen((value) {
                  //widget.readValues[characteristic.uuid] = value;
                });
                await characteristic.setNotifyValue(true);
              },
            ),
          ),
        ),
      );
    }

    return buttons;
  }

  ListView _buildChargeBotView() {
    tempservice = _services![2];

    for (BluetoothCharacteristic characteristic
        in tempservice!.characteristics) {
      if (characteristic.properties.write)
        _writecharacteristic = characteristic;
      if (characteristic.properties.notify)
        _nodifycharacteristic = characteristic;
    }
    List<Container> containers = <Container>[];
    containers.add(
      Container(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 200.0,
                      height: 35.0,
                      child: RaisedButton(
                        child: Text("Nodification",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          _nodifycharacteristic!.value.listen((value) {
                            setState(() {
                              switch (comandKind) {
                                case 0:
                                  widget.readValues[0] = value;
                                  break;
                                case 1:
                                  widget.readValues[1] = value;
                                  break;
                                case 2:
                                  widget.readValues[2] = value;
                                  break;
                                case 3:
                                  widget.readValues[3] = value;
                                  break;
                                case 4:
                                  widget.readValues[4] = value;
                                  break;
                                case 5:
                                  widget.readValues[5] = value;
                                  break;
                                case 6:
                                  widget.readValues[6] = value;
                                  break;
                                case 7:
                                  widget.readValues[7] = value;
                                  break;
                                case 8:
                                  widget.readValues[8] = value;
                                  break;
                                case 9:
                                  widget.readValues[9] = value;
                                  break;
                                case 10:
                                  widget.readValues[10] = value;
                                  break;
                                case 11:
                                  widget.readValues[11] = value;
                                  break;
                                case 12:
                                  widget.readValues[12] = value;
                                  break;
                                case 13:
                                  widget.readValues[13] = value;
                                  break;
                                case 14:
                                  widget.readValues[14] = value;
                                  break;
                                case 15:
                                  widget.readValues[15] = value;
                                  break;
                                case 16:
                                  widget.readValues[16] = value;
                                  break;
                                case 17:
                                  widget.readValues[17] = value;
                                  break;
                                case 18:
                                  widget.readValues[18] = value;
                                  break;
                                case 19:
                                  widget.readValues[19] = value;
                                  break;
                                case 20:
                                  widget.readValues[20] = value;
                                  break;
                              }
                            });
                          });
                          await _nodifycharacteristic!.setNotifyValue(true);
                        },
                      ),
                    ),
                  ]),
              Row(children: <Widget>[
                SizedBox(width: 20),
                ButtonTheme(
                  minWidth: 100.0,
                  height: 35.0,
                  child: RaisedButton(
                    child:
                        Text("PowerOff", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      comandKind = 0;
                      _writecharacteristic!.write(_buildChargeBotCommand(160));
                    },
                  ),
                ),
                SizedBox(width: 80),
                Text(
                  widget.readValues[0] != null
                      ? getRealValueFromArray(widget.readValues[0]!).toString()
                      : "--",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: AppColors.primary),
                ), // widget.readValues[0].toString()),
              ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       child:
              //           Text("FVersion", style: TextStyle(color: Colors.white)),
              //       onPressed: () {
              //         comandKind = 1;
              //         _writecharacteristic?.write(_buildChargeBotCommand(80));
              //       },
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[1]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       child:
              //           Text("BatLevL", style: TextStyle(color: Colors.white)),
              //       onPressed: () {
              //         comandKind = 2;
              //         _writecharacteristic?.write(_buildChargeBotCommand(81));
              //       },
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[2]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 3;
              //         _writecharacteristic?.write(_buildChargeBotCommand(82));
              //       },
              //       child:
              //           Text("BatTemp", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[3]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 4;
              //         _writecharacteristic?.write(_buildChargeBotCommand(84));
              //       },
              //       child:
              //           Text("BatVolt", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[4]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 5;
              //         _writecharacteristic?.write(_buildChargeBotCommand(85));
              //       },
              //       child:
              //           Text("BatCurt", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[5]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 6;
              //         _writecharacteristic?.write(_buildChargeBotCommand(86));
              //       },
              //       child:
              //           Text("BatPow", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[6]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 7;
              //         _writecharacteristic?.write(_buildChargeBotCommand(87));
              //       },
              //       child: Text("SolarVolt",
              //           style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[7]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 8;
              //         _writecharacteristic?.write(_buildChargeBotCommand(88));
              //       },
              //       child: Text("SolarCurt",
              //           style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[8]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 9;
              //         _writecharacteristic?.write(_buildChargeBotCommand(89));
              //       },
              //       child:
              //           Text("SolarPow", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[9]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 10;
              //         _writecharacteristic?.write(_buildChargeBotCommand(90));
              //       },
              //       child:
              //           Text("12Volt", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[10]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 11;
              //         _writecharacteristic?.write(_buildChargeBotCommand(97));
              //       },
              //       child:
              //           Text("PupState", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[11]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 12;
              //         _writecharacteristic?.write(_buildChargeBotCommand(93));
              //       },
              //       child:
              //           Text("BatState", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[12]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 13;
              //         _writecharacteristic?.write(_buildChargeBotCommand(1));
              //       },
              //       child:
              //           Text("SN-0102", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[13]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 14;
              //         _writecharacteristic?.write(_buildChargeBotCommand(2));
              //       },
              //       child:
              //           Text("SN-0304", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[14]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 15;
              //         _writecharacteristic?.write(_buildChargeBotCommand(3));
              //       },
              //       child:
              //           Text("SN-0506", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[15]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 16;
              //         _writecharacteristic?.write(_buildChargeBotCommand(4));
              //       },
              //       child:
              //           Text("SN-0708", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[16]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 17;
              //         _writecharacteristic?.write(_buildChargeBotCommand(5));
              //       },
              //       child:
              //           Text("SN-0910", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[17]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 18;
              //         _writecharacteristic?.write(_buildChargeBotCommand(6));
              //       },
              //       child:
              //           Text("SN-1112", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[18]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 19;
              //         _writecharacteristic?.write(_buildChargeBotCommand(7));
              //       },
              //       child:
              //           Text("SN-1314", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[19]!).toString()),
              // ]),
              // Row(children: <Widget>[
              //   SizedBox(width: 20),
              //   ButtonTheme(
              //     minWidth: 100.0,
              //     height: 35.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         comandKind = 20;
              //         _writecharacteristic!.write(_buildChargeBotCommand(8));
              //       },
              //       child:
              //           Text("SN-1516", style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              //   SizedBox(width: 80),
              //   Text('Value:' +
              //       getRealValueFromArray(widget.readValues[20]!).toString()),
              // ])
            ],
          ),
        ),
      ),
    );
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  int getRealValueFromArray(List<int> data) {
    print("+++++++++++++++++++++++++++++");
    print(data);
    print("+++++++++++++++++++++++++++++");
    List<int> temp = <int>[];
    temp = data;
    if (temp == null) return 0;
    if (temp.length == 0)
      return 0;
    else {
      return (temp[3] << 8) + temp[4];
    }
  }

  List<int> _buildChargeBotCommand(int command) {
    List<int> cmd = <int>[];
    cmd.add(170);
    cmd.add(1);
    cmd.add(command);
    cmd.add(0);
    cmd.add(0);
    return cmd;
  }

  ListView _buildView() {
    if (_connectedDevice != null) {
      if (!_connectedDevice!.name.contains("Chargebot")) {
        return _buildChargeBotView();
      }
    }
    return _buildListViewOfDevices();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppPrimaryBar(),
        body: _buildView(),
      );

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
}
