import 'dart:developer';

import 'package:doctor_dreams/screens/hardware/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../../../config/appColors.dart';

class PairDeviceScreen extends StatefulWidget {
  const PairDeviceScreen({Key? key}) : super(key: key);

  @override
  State<PairDeviceScreen> createState() => _PairDeviceScreenState();
}

class _PairDeviceScreenState extends State<PairDeviceScreen> {
  var isBack = false;
  late List<BluetoothService> _services;

  @override
  void initState() {
    super.initState();
    _scanDevice();
  }

  _scanDevice() {
    FlutterBlue.instance.startScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.primary),
        titleTextStyle: TextStyle(color: AppColors.primary),
        title: Text(
          "Devices List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => FlutterBlue.instance.startScan(),
        child:StreamBuilder<List<ScanResult>>(
            stream: FlutterBlue.instance.scanResults,
            initialData: [],
            builder: (c, snapshot) {
              print(snapshot.data!.length);
              return Column(
                children: [
                  snapshot.data!.length>0?
                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      if (!snapshot.data![i].device.name
                          .contains("Chargebot")) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ScanResultTile(
                              result: snapshot.data![i],
                              onTap: () async {
                                try {
                                  await snapshot
                                      .data![i].device
                                      .connect();
                                } catch (e) {
                                  if (e !=
                                      'already_connected') {
                                    throw e;
                                  }
                                } finally {
                                  _services = await snapshot
                                      .data![i].device
                                      .discoverServices();
                                  //Navigator.pop(context);
                                  ScaffoldMessenger.of(
                                      context)
                                      .showSnackBar(SnackBar(
                                      content: Text(
                                          "Connected")));
                                }
                              }),
                        );
                      }
                      return Visibility(
                        visible: isBack,
                        child: Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text(
                            "Device not found..!",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                color: AppColors.primary,
                                fontSize: 14),
                          ),
                        ),
                      );
                    },
                  ):Expanded(
                    child: Center(
                      child: Text(
                        "Device not found..!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;
          if (state == BluetoothState.on) {
            return StreamBuilder<bool>(
              stream: FlutterBlue.instance.isScanning,
              initialData: false,
              builder: (c, snapshot) {
                if (snapshot.data!) {
                  return Visibility(
                    visible: false,
                    child: FloatingActionButton(
                      child: Icon(Icons.stop),
                      onPressed: () => FlutterBlue.instance.stopScan(),
                      backgroundColor: AppColors.secondary,
                    ),
                  );
                } else {
                  if (isBack) {
                    FlutterBlue.instance.startScan();
                    isBack = false;
                  }
                  return Visibility(
                    visible: false,
                    child: FloatingActionButton(
                        backgroundColor: AppColors.secondary,
                        child: Icon(
                          Icons.search,
                          color: AppColors.secondary,
                        ),
                        onPressed: () => FlutterBlue.instance.startScan()),
                  );
                }
              },
            );
          } else {
            return Visibility(
              visible: true,
              child: Container(
                margin: EdgeInsets.only(left: 33.0, top: 100),
                child: Center(
                  child: Text(
                    'Please turn on bluetooth',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ),
              /*child: FloatingActionButton(
                backgroundColor: AppTheme.primaryColor,
                child: Icon(
                  Icons.search,
                  color: AppTheme.colorLightGreyMenu,
                ),
                onPressed: () => Constants.toast("Please turn on bluetooth")),*/
            );
          }
        },
      ),
    );
  }
}
