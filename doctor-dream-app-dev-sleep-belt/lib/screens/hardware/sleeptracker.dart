// import 'package:doctor_dreams/config/appColors.dart';
// import 'package:doctor_dreams/widgets/appBar.dart';
// import 'package:doctor_dreams/widgets/bottomNav.dart';
// import 'package:doctor_dreams/widgets/drawer.dart';
// import 'package:flutter/material.dart';

// class SleepTracker extends StatefulWidget {
//   const SleepTracker({Key? key}) : super(key: key);

//   @override
//   _SleepTrackerState createState() => _SleepTrackerState();
// }

// class _SleepTrackerState extends State<SleepTracker> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppPrimaryBar(isSleetBelt: true),
//         drawer: AppDrawer(),
//         body: Container(
//             decoration: new BoxDecoration(color: AppColors.primary),
//             child: myLayoutWidget(context)),
//         bottomNavigationBar: BottomNavBar());
//   }
// }

// Widget myLayoutWidget(BuildContext context) {
//   return Column(
//     children: [
//       Align(
//         alignment: Alignment.topLeft,
//         child: Padding(
//           padding:
//               const EdgeInsets.only(left: 30, top: 130, right: 0, bottom: 0),
//           child: Text(
//             "Sleep Tracking",
//             style: TextStyle(
//                 fontSize: 40,
//                 color: AppColors.white,
//                 fontWeight: FontWeight.w400),
//           ),
//         ),
//       ),
//     ],
//   );
// }

import 'package:doctor_dreams/home.dart';
import 'package:doctor_dreams/widgets/alarm_tab.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/profile_tab.dart';
import 'package:doctor_dreams/widgets/stats_tab.dart';
import 'package:flutter/material.dart';

/*
  The entire home screen consisting of three tabs.
 */
class SleepTracker extends StatefulWidget {
  const SleepTracker({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SleepTrackerState();
}

class _SleepTrackerState extends State<SleepTracker> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initializes notification
    // var initializationSettingsAndroid =
    //     AndroidInitializationSettings('app_icon');
    // var initializationSettingsIOS = IOSInitializationSettings();
    // var initializationSettings = InitializationSettings(
    //     initializationSettingsAndroid, initializationSettingsIOS);
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: onSelectNotification);

    // flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         IOSFlutterLocalNotificationsPlugin>()
    //     ?.requestPermissions(
    //       alert: true,
    //       badge: true,
    //       sound: true,
    //     );

    // TODO: remove when release
    // setUpFakeDatabase();
  }

  // void setUpFakeDatabase() async {
  //   var database = MyDatabase.instance;
  //   var db = await database.database;
  //   database
  //       .insertSleep(Sleep(id: 0, start: 1589172747000, end: 1589205147000));
  //   database
  //       .insertSleep(Sleep(id: 1, start: 1588920747000, end: 1588950747000));
  // }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('Notification payload: ' + payload);
    }
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [AlarmTab(), StatsTab(), ProfileTab()];
    final List<String> titles = ["Alarm", "Statistics", "Profile"];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_selectedIndex],
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        brightness: Brightness.dark,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              // label: SizedBox.shrink(),
              label: "test",
              icon: Icon(
                Icons.alarm,
                size: 33.0,
              )),
          BottomNavigationBarItem(
              // title: SizedBox.shrink(),
              label: "test",
              icon: Icon(
                Icons.equalizer,
                size: 33.0,
              )),
          BottomNavigationBarItem(
              label: "test",

              // title: SizedBox.shrink(),
              icon: Icon(
                Icons.person,
                size: 33.0,
              ))
        ],
      ),
      // bottomNavigationBar: BottomNavBar(),
      body: tabs[_selectedIndex],
    );
  }
}
