import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:oscilloscope/oscilloscope.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({Key? key, this.device}) : super(key: key);
  final BluetoothDevice? device;

  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  BluetoothState? state;
  BluetoothDeviceState? deviceState;
  // final String SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  // final String CHARACTERISTIC_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  final String SERVICE_UUID = "0000fff0-0000-1000-8000-00805f9b34fb";

  static const UUIDSTR_ISSC_TRANS_TX = "0000fff6-0000-1000-8000-00805f9b34fb";
  static const UUIDSTR_ISSC_TRANS_RX = "0000fff7-0000-1000-8000-00805f9b34fb";
  late bool isReady;
  late Stream<List<int>> stream;
  BluetoothCharacteristic? c;
  late var bluetoothInstance = FlutterBlue.instance;
  late var scanSubscription;
  late var device;

  // late List<double> traceDust = List();

  @override
  void initState() {
    super.initState();
    FlutterBlue.instance.state.listen((state) {
      if (state == BluetoothState.off) {
//Alert user to turn on bluetooth.
      } else if (state == BluetoothState.on) {
//if bluetooth is enabled then go ahead.
//Make sure user's device gps is on.
        scanForDevices();
      }
    });
  }

  void scanForDevices() async {
    scanSubscription = bluetoothInstance.scan().listen((scanResult) async {
      if (scanResult.device.name == "your_device_name") {
        print("found device");
//Assigning bluetooth device
        device = scanResult.device;
//After that we stop the scanning for device
        stopScanning();
      }
    });
  }

  void stopScanning() {
    bluetoothInstance.stopScan();
    scanSubscription.cancel();
  }

  connectToDevice() async {
//flutter_blue makes our life easier
    await device.connect();
//After connection start discovering services
    discoverServices();
  }

  discoverServices() async {
    List<BluetoothService> services = await device.discoverServices();
//checking each services provided by device
    services.forEach((service) {
      if (service.uuid.toString() == SERVICE_UUID) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == UUIDSTR_ISSC_TRANS_RX) {
//Updating characteristic to perform write operation.
            c = characteristic;
          } else if (characteristic.uuid.toString() == UUIDSTR_ISSC_TRANS_TX) {
//Updating stream to perform read operation.
            stream = characteristic.value;
            characteristic.setNotifyValue(!characteristic.isNotifying);
          }
        });
      }
    });
  }

  interpretReceivedData(String data) async {
    if (data == "abt_HANDS_SHAKE") {
//Do something here or send next command to device
      sendTransparentData('Hello');
    } else {
      print("Determine what to do with $data");
    }
  }

  sendTransparentData(String dataString) async {
//Encoding the string
    List<int> data = utf8.encode(dataString);
    if (deviceState == BluetoothDeviceState.connected) {
      await c?.write(data);
    }
  }

  String _dataParser(List<int> dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }

  @override
  Widget build(BuildContext context) {
    // Oscilloscope oscilloscope = Oscilloscope(
    //   showYAxis: true,
    //   padding: 0.0,
    //   backgroundColor: Colors.black,
    //   traceColor: Colors.white,
    //   yAxisMax: 3000.0,
    //   yAxisMin: 0.0,
    //   dataSet: traceDust,
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text('Optical Dust Sensor'),
      ),
      body: Container(
          child: Container(
        child: StreamBuilder<List<int>>(
          stream: stream,
          initialData: [],
          builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');

            if (snapshot.connectionState == ConnectionState.active) {
              var currentValue = _dataParser(snapshot.data!);
              // print(
              //     "++++++++++++++++++++++currentValue++++++++++++++++++++");
              // print(currentValue);
              // traceDust.add(double.tryParse(currentValue) ?? 0);
              interpretReceivedData(currentValue);
              return Center(child: Text('We are finding the data..'));
              // return Center(
              //     child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Expanded(
              //       flex: 1,
              //       child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: <Widget>[
              //             Text('Current value from Sensor',
              //                 style: TextStyle(fontSize: 14)),
              //             Text('${currentValue} ug/m3',
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 24))
              //           ]),
              //     ),
              //     // Expanded(
              //     //   flex: 1,
              //     //   // child: oscilloscope,
              //     // )
              //   ],
              // ));
            } else {
              return Text('Check the stream');
            }
          },
        ),
      )),
    );
  }
}
