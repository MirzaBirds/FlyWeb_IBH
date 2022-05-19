import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:convert/convert.dart';

import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/screens/hardware/productList.dart';
import 'package:doctor_dreams/screens/hardware/widget.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class FindDevice extends StatefulWidget {
  static const String id = 'productList';
  const FindDevice({Key? key}) : super(key: key);

  @override
  _FindDeviceState createState() => _FindDeviceState();
}

class _FindDeviceState extends State<FindDevice> {
  @override
  void initState() {
    // TODO: implement initState
    Uint8List list = new Uint8List(17);
    list[0] = 0x01;
    list[1] = 0x12;
    list[2] = 0x00;
    list[3] = 0x00;
    list[4] = 0x00;
    list[5] = 0x00;
    list[6] = 0x00;
    list[7] = 0x00;
    list[8] = 0x00;
    list[9] = 0x00;
    list[10] = 0x00;
    list[11] = 0x00;
    list[12] = 0x00;
    list[13] = 0x00;
    list[14] = 0x00;
    list[15] = 0x00;
    list[16] = 0x00;
    print("+++++++++++++++++++++++LIST++++++++++++++++++");
    print(list);

    // final buffer = Uint16List.fromList(list).buffer;
    // final byteDataCreator = ByteDataCreator.view(buffer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppPrimaryBar(),
      drawer: AppDrawer(),
      body: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return FindDevicesScreen();
            }
            return BluetoothOffScreen(state: state);
          }),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Find Devices'),
      // ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map((d) => ListTile(
                            title: Text(d.name),
                            subtitle: Text(d.id.toString()),
                            trailing: StreamBuilder<BluetoothDeviceState>(
                              stream: d.state,
                              initialData: BluetoothDeviceState.disconnected,
                              builder: (c, snapshot) {
                                if (snapshot.data ==
                                    BluetoothDeviceState.connected) {
                                  return RaisedButton(
                                    child: Text('OPEN'),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DeviceScreen(device: d))),
                                  );
                                }
                                return Text(snapshot.data.toString());
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map<Widget>(
                        (r) => ScanResultTile(
                          result: r,
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            r.device.connect();
                            return DeviceScreen(device: r.device);
                          })),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice? device;

  static List<int> generateValue(int size) {
    final List<int> value = List<int>.generate(size, (int index) {
      return 0;
    });
    return value;
  }

  static List<int> setWeather() {
    final List<int> value = generateValue(17);
    value[0] = 0x01;
    value[1] = 0x12;
    value[2] = 0x00;
    value[3] = 0x00;
    value[4] = 0x00;
    value[5] = 0x00;
    value[6] = 0x00;
    value[7] = 0x00;
    value[8] = 0x00;
    value[9] = 0x00;
    value[10] = 0x00;
    value[11] = 0x00;
    value[12] = 0x00;
    value[13] = 0x00;
    value[14] = 0x00;
    value[15] = 0x00;
    value[15] = 0x00;
    return value;

    // return hex.encode(value);
  }

  List<int> _getRandomBytes() {
    // final math = Random();
    // Uint8List list = new Uint8List(13);
    // list[0] = 0x01;
    // list[1] = 0x12;
    // list[2] = 0x00;
    // list[3] = 0x00;
    // list[4] = 0x00;
    // list[5] = 0x00;
    // list[6] = 0x00;
    // list[7] = 0x00;
    // list[8] = 0x00;
    // list[9] = 0x00;
    // list[10] = 0x00;
    // list[11] = 0x00;
    // list[12] = 0x00;
    // list[13] = 0x00;
    // list[14] = 0x00;
    // list[16] = 0x00;
    // list[17] = 0x00;
    // print("+++++++++++++++++++++++LIST++++++++++++++++++");
    print([
      0x01,
      0x12,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00
    ]);
    return [
      0x01,
      0x12,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00
    ];
    // return list;

    // return [
    //   math.nextInt(255),
    //   math.nextInt(255),
    //   math.nextInt(255),
    //   math.nextInt(255)
    // ];
  }

  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .map<Widget>(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile(
                    characteristic: c,
                    onReadPressed: () => c.read(),
                    onWritePressed: () async {
                      await c.write((setWeather()), withoutResponse: true);
                      await c.read();
                    },
                    onNotificationPressed: () async {
                      await c.setNotifyValue(!c.isNotifying);
                      await c.read();
                    },
                    descriptorTiles: c.descriptors
                        .map(
                          (d) => DescriptorTile(
                            descriptor: d,
                            onReadPressed: () => d.read(),
                            onWritePressed: () =>
                                d.write(Uint8List.fromList(setWeather())),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device!.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device!.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device!.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device!.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device!.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device!.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device!.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data! ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => device!.discoverServices(),
                      ),
                      IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: device!.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => device!.requestMtu(223),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device!.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class findDevice extends StatelessWidget {
//   const findDevice({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//           padding: EdgeInsets.only(left: 25, right: 25, top: 25),
//           child: Column(children: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 // Navigator.push(context,
//                 //     MaterialPageRoute(builder: (context) => LoginScreen()));
//                 print("Find New Devices ");
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width / 1.5,
//                 padding: EdgeInsets.symmetric(vertical: 13),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15.0),
//                   color: AppColors.primary,
//                 ),
//                 child: Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Fine New Devices',
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                       Icon(Icons.repeat, color: AppColors.white),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               height: 150,
//               child: Card(
//                 color: AppColors.secondary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 // elevation: 10,
//                 child: Padding(
//                   padding:
//                       EdgeInsets.only(left: 10, top: 25, right: 0, bottom: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Column(
//                           children: [
//                             Text(
//                               "Sleep Belt",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w300,
//                                   fontSize: 28,
//                                   color: AppColors.white),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 print("button press");
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                       builder: (BuildContext context) =>
//                                           productList()),
//                                 );
//                               },
//                               child: Container(
//                                 width: 100,
//                                 padding: EdgeInsets.symmetric(vertical: 5),
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5.0),
//                                     color: AppColors.white),
//                                 child: Text(
//                                   'Pair Device',
//                                   style: TextStyle(
//                                       fontSize: 15, color: Colors.black),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(0.0),
//                         child: GestureDetector(
//                           onTap: () {},
//                           child: Container(
//                             child: Image.asset(
//                               'assets/wa1.png',
//                               height: 150,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ])),
//     );
//   }
// }
