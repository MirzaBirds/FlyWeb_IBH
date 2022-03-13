import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/home.dart';
import 'package:doctor_dreams/screens/ecommerce/experienceCenter.dart';
import 'package:doctor_dreams/screens/ecommerce/productCategory.dart';
import 'package:doctor_dreams/screens/hardware/sleepingScreen.dart';
import 'package:doctor_dreams/screens/hardware/sleeptracker.dart';
import 'package:doctor_dreams/screens/hardware/wakeupScreen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.call,
      size: 150,
    ),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      print(_selectedIndex);
      if (_selectedIndex == 0) {
        print("Home");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const Home(),
          ),
        );
      } else if (_selectedIndex == 1) {
        print("experience center");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const ExperienceCenter(),
          ),
        );
      }
      if (_selectedIndex == 2) {
        print("Sleep Tracker Screen");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            // builder: (BuildContext context) => const SleepTracker(),
            builder: (BuildContext context) => const WakeUpScreen(),
          ),
        );
      }
      if (_selectedIndex == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const ProductCategory(),
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
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColors.primary,
          icon: ImageIcon(AssetImage('assets/sleep.png')),
          // icon: Icon(Icons.star_rate_outlined),
          label: 'Experience Center',
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColors.primary,
          icon: ImageIcon(AssetImage('assets/tracker.png')),
          label: 'Sleep Tracker',
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColors.primary,
          icon: ImageIcon(AssetImage('assets/e-sleep.png')),
          label: 'Sleep Essentials',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
