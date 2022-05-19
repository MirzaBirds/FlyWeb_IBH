import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class SleepBelt extends StatefulWidget {
  const SleepBelt({Key? key, this.device}) : super(key: key);
  final BluetoothDevice? device;

  @override
  State<SleepBelt> createState() => _SleepBeltState();
}

class _SleepBeltState extends State<SleepBelt> {
  final String SERVICE_UUID = "0000fff0-0000-1000-8000-00805f9b34fb";
  final String CHARACTERISTIC_UUID = "0000fff6-0000-1000-8000-00805f9b34fb";

  late bool isReady;
  late Stream<List<int>> stream;
  // late List<double> traceDust = List();

  @override
  void initState() {
    super.initState();
    isReady = false;
    connectToDevice();
  }

  connectToDevice() async {
    if (widget.device == null) {
      Navigator.of(context).pop(true);
      return;
    }

    new Timer(const Duration(seconds: 15), () {
      if (!isReady) {
        disconnectFromDevice();
        Navigator.of(context).pop(true);
      }
    });

    await widget.device?.connect();
    discoverServices();
  }

  disconnectFromDevice() {
    if (widget.device == null) {
      Navigator.of(context).pop(true);
      return;
    }

    widget.device?.disconnect();
  }

  discoverServices() async {
    if (widget.device == null) {
      Navigator.of(context).pop(true);
      return;
    }

    List<BluetoothService> services = await widget.device!.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == SERVICE_UUID) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
            characteristic.setNotifyValue(!characteristic.isNotifying);
            stream = characteristic.value;
            print(
                "+++++++++++++++++++++++++++VALUE+++++++++++++++++++++++++++");
            setState(() {
              isReady = true;
            });
          }
        });
      }
    });

    if (!isReady) {
      Navigator.of(context).pop(true);
    }
  }

  Pop() {
    Navigator.of(context).pop(true);
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
          child: !isReady
              ? Center(
                  child: Text(
                    "Waiting...",
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                )
              : Container(
                  child: StreamBuilder<List<int>>(
                    stream: stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<int>> snapshot) {
                      print("++++++++++++++snapshot++++++++++");
                      print(snapshot);
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');

                      if (snapshot.connectionState == ConnectionState.active) {
                        var currentValue = _dataParser(snapshot.data!);
                        // traceDust.add(double.tryParse(currentValue) ?? 0);

                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Current value from Sensor',
                                        style: TextStyle(fontSize: 14)),
                                    Text('${currentValue} ug/m3',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24))
                                  ]),
                            ),
                            // Expanded(
                            //   flex: 1,
                            //   child: oscilloscope,
                            // )
                          ],
                        ));
                      } else {
                        return Text('Check the stream');
                      }
                    },
                  ),
                )),
    );
  }
}
