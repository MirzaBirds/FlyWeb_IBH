import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/home.dart';
import 'package:doctor_dreams/screens/ecommerce/experienceCenter.dart';
import 'package:doctor_dreams/screens/ecommerce/productCategory.dart';
import 'package:doctor_dreams/screens/hardware/pairDevice1.dart';
import 'package:doctor_dreams/screens/hardware/sleep_belt/accountManagement.dart';
import 'package:doctor_dreams/screens/hardware/sleep_belt/reportDevice.dart';
import 'package:doctor_dreams/screens/hardware/sleepingScreen.dart';
import 'package:doctor_dreams/screens/hardware/sleeptracker.dart';
import 'package:doctor_dreams/screens/hardware/wakeupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../screens/hardware/sleep_belt/monitorDevice.dart';

class TopNavBar extends StatefulWidget {

  final BluetoothDevice device;
  final List<BluetoothService> services;

  const TopNavBar({Key? key, required this.device, required this.services}) : super(key: key);

  @override
  _TopNavBarState createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      print(_selectedIndex);
      if (_selectedIndex == 0) {
        print("Home");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>  ReportDeviceScreen(device: widget.device,
              services:widget.services,),
          ),
        );
      } else if (_selectedIndex == 1) {
        print("experience center");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>MonitorDeviceScreen(device: widget.device,
              services:widget.services,),
          ),
        );
      }
      if (_selectedIndex == 2) {
        print("Sleep Tracker Screen");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            // builder: (BuildContext context) => const SleepTracker(),
            builder: (BuildContext context) => AccountManagementScreen(device: widget.device,
              services:widget.services,),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // currentIndex: 2,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.white,
      unselectedItemColor: Colors.white,
      backgroundColor: AppColors.primary,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: AppColors.white,
          icon: Visibility(visible:false,child: Icon(Icons.home_outlined)),
          label: 'Report',
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColors.primary,
          icon: Visibility(visible:false,child: ImageIcon(AssetImage('assets/sleep.png'))),
          // icon: Icon(Icons.star_rate_outlined),
          label: 'Monitor',
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColors.primary,
          icon: Visibility(visible:false,child: ImageIcon(AssetImage('assets/tracker.png'))),
          label: 'Account',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
