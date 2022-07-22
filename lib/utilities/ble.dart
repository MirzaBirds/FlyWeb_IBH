import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';

import 'package:hex/hex.dart';

class BLE {
  BLE();
  final frb = FlutterReactiveBle();
  StreamSubscription? subscription;
  late StreamSubscription<ConnectionStateUpdate> connection;
  QualifiedCharacteristic? tx;
  QualifiedCharacteristic? rx;
  String status = 'not connected';
  static final String BASE = "-0000-1000-8000-00805f9b34fb";
  static String response = '';
  int value = 0;

  Future<void> stopScan() async {
    await subscription?.cancel();
    subscription = null;
  }

  String getStatus() {
    return status;
  }

  void sendData() async {
    print("+++++++++++++++++++++++++++++++++++++");
    print("writing data");
    print(getRealTimeHeartRate());
    print("+++++++++++++++++++++++++++++++++++++");
    await frb.writeCharacteristicWithoutResponse(tx!,
        value: getRealTimeHeartRate());
  }

  String readData() {
    return response;
  }

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

  static getReadableResponse(data) {
    print("+++++++++++++++++++++++++++++++++");
    print("return data");
    print(HEX.encode(data));
    response = HEX.encode(data);
  }

  static List<int> getDeviceTime() {
    final List<int> value = _generateInitValue(); //16
    // final int year = 2022;
    // final int month = 5;
    // final int day = 20;
    // final int hour = 00;
    // final int minute = 00;
    // final int second = 00;
    value[0] = 0x41;
    // value[1] = _getBcdValue(year);
    // value[2] = _getBcdValue(month);
    // value[3] = _getBcdValue(day);
    // value[4] = _getBcdValue(hour);
    // value[5] = _getBcdValue(minute);
    // value[6] = _getBcdValue(second);
    crcValue(value);
    return value;
  }

  // void connectToBLE() async {
  //   subscription = frb.scanForDevices(
  //       withServices: [Uuid.parse("0000fff0" + BASE)]).listen((device) {
  //     connection = frb.connectToDevice(id: device.id).listen((state) {
  //       if (state.connectionState == DeviceConnectionState.connected) {
  //         // get tx

  //         print("in connection ------------------");
  //         tx = QualifiedCharacteristic(
  //             serviceId: Uuid.parse("0000fff0" + BASE),
  //             characteristicId: Uuid.parse("0000fff6" + BASE),
  //             deviceId: device.id);

  //         // get rx
  //         rx = QualifiedCharacteristic(
  //             serviceId: Uuid.parse("0000fff0" + BASE),
  //             characteristicId: Uuid.parse("0000fff7" + BASE),
  //             deviceId: device.id);

  //         // subscribe to rx
  //         frb.subscribeToCharacteristic(rx!).listen((data) {
  //           value = 0;
  //           value += (data[0] - 48).toUnsigned(8) * 10000;
  //           value += (data[1] - 48).toUnsigned(8) * 1000;
  //           value += (data[2] - 48).toUnsigned(8) * 100;
  //           value += (data[3] - 48).toUnsigned(8) * 10;
  //           value += (data[4] - 48).toUnsigned(8) * 1;
  //           print("++++++++++++++++++++++++++++++++++++++");
  //           print("Reading Data");
  //           print("++++++++++++++++++++++++++++++++++++++");
  //           print(data);
  //           response = value;
  //         }, onError: (Object e) {
  //           print('subscribe error: $e\n');
  //         });

  //         status = 'connected';
  //         stopScan();
  //       }
  //     }, onError: (Object e) {
  //       // connecting error
  //       print('error: $e\n');
  //     });
  //   }, onError: (Object e) {
  //     // scan error
  //     print('error: $e\n');
  //   });
  // }

  // Flutter connect device new

  void connectToBLE() async {
    subscription = frb.scanForDevices(
        withServices: [Uuid.parse("0000fff0" + BASE)]).listen((device) {
      connection = frb.connectToDevice(id: device.id).listen((state) {
        if (state.connectionState == DeviceConnectionState.connected) {
          // get tx

          print("in connection ------------------");
          tx = QualifiedCharacteristic(
              serviceId: Uuid.parse("0000fff0" + BASE),
              characteristicId: Uuid.parse("0000fff6" + BASE),
              deviceId: device.id);

          // get rx
          rx = QualifiedCharacteristic(
              serviceId: Uuid.parse("0000fff0" + BASE),
              characteristicId: Uuid.parse("0000fff7" + BASE),
              deviceId: device.id);

          // subscribe to rx
          frb.subscribeToCharacteristic(rx!).listen((data) {
            value = 0;
            value += (data[0] - 48).toUnsigned(8) * 10000;
            value += (data[1] - 48).toUnsigned(8) * 1000;
            value += (data[2] - 48).toUnsigned(8) * 100;
            value += (data[3] - 48).toUnsigned(8) * 10;
            value += (data[4] - 48).toUnsigned(8) * 1;
            print("++++++++++++++++++++++++++++++++++++++");
            print("Reading Data");
            print("++++++++++++++++++++++++++++++++++++++");
            print(data);

            // List<int> value = [253, 165, 6, 147, 164, 226, 79, 177, 175, 207, 198, 235, 7, 100, 120, 37];
            // var result = hex.encode(value);
            getReadableResponse(data);

            // response = value;
          }, onError: (Object e) {
            print('subscribe error: $e\n');
          });

          status = 'connected';
          stopScan();
        }
      }, onError: (Object e) {
        // connecting error
        print('error: $e\n');
      });
    }, onError: (Object e) {
      // scan error
      print('error: $e\n');
    });
  }
}
