import 'dart:async';
import 'dart:math';

import 'package:doctor_dreams/screens/hardware/pairDevice1.dart';
import 'package:doctor_dreams/screens/hardware/wakeupScreen.dart';
import 'package:doctor_dreams/utils.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

/*
  The screen user sees when sleeping.
 */
class SleepingScreen extends StatefulWidget {
  const SleepingScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SleepingScreenState();
}

class _SleepingScreenState extends State<SleepingScreen> {
  late int _alarmTimestamp, _timeLeft;
  String _soundName = "Analog watch";
  late StreamSubscription _sub;

  void setUp() async {
    // Setup preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _alarmTimestamp =
        prefs.getInt("alarm") ?? DateTime.now().millisecondsSinceEpoch;
    _soundName = prefs.getString("sound") ?? "Analog watch";

    // Setup timer
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    int timeLeft = _alarmTimestamp - currentTimestamp;

    // scheduleNotification(timeLeft);
    print(timeLeft);
    // CountdownTimer countdownTimer =
    //     CountdownTimer(Duration(milliseconds: timeLeft), Duration(seconds: 1));
    // _sub = countdownTimer.listen(null);
    _sub.onData((duration) {
      timeLeft -= 1000;

      this.onTimerTick(timeLeft);
      print('Counting down: $timeLeft');
    });

    _sub.onDone(() {
      print("Done.");
      _sub.cancel();
      // Transition to wake up page.
      Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                PairDevice1(isSleetbelt: true),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ));

//      Navigator.pushAndRemoveUntil(
//          context,
//          PageRouteBuilder(
//            pageBuilder: (context, animation, secondaryAnimation) =>
//                WakeUpScreen(),
//            transitionsBuilder:
//                (context, animation, secondaryAnimation, child) {
//              var begin = Offset(0.0, 1.0);
//              var end = Offset.zero;
//              var curve = Curves.ease;
//              var tween =
//                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//              return SlideTransition(
//                position: animation.drive(tween),
//                child: child,
//              );
//            },
//          ),
//          (Route<dynamic> route) => false);
    });
  }

  /*
    Called each second.
   */
  void onTimerTick(int newTimestamp) {
    setState(() {
      _timeLeft = newTimestamp;
    });
  }

  /*
    Schedules a notification timeLeft in the future.
   */
  // void scheduleNotification(int timeLeft) {
  //   var scheduledNotificationDateTime =
  //       DateTime.now().add(Duration(milliseconds: timeLeft));
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'Unique id', 'channel name', 'channel description');
  //   var iOSPlatformChannelSpecifics =
  //       IOSNotificationDetails(sound: alarmMap[_soundName]); // TODO: test
  //   NotificationDetails platformChannelSpecifics = NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   flutterLocalNotificationsPlugin.schedule(0, "Alarm", "Wake up!",
  //       scheduledNotificationDateTime, platformChannelSpecifics);
  // }

  @override
  void initState() {
    super.initState();
    _timeLeft = 0;
    // setUp();
  }

  @override
  Widget build(BuildContext context) {
    final _cancelButton = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.teal,
      ),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.37,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          setState(() {
            // Removes previously scheduled notification.
            // flutterLocalNotificationsPlugin.cancelAll();

            Navigator.pop(context);

            // TODO: back
//            Navigator.pushAndRemoveUntil(
//                context,
//                PageRouteBuilder(
//                  pageBuilder: (context, animation, secondaryAnimation) =>
//                      HomeScreen(),
//                  transitionsBuilder:
//                      (context, animation, secondaryAnimation, child) {
//                    var begin = Offset(0.0, -1.0);
//                    var end = Offset.zero;
//                    var curve = Curves.ease;
//                    var tween = Tween(begin: begin, end: end)
//                        .chain(CurveTween(curve: curve));
//                    return SlideTransition(
//                      position: animation.drive(tween),
//                      child: child,
//                    );
//                  },
//                ),
//                (Route<dynamic> route) => false);
          });
        },
        child: Text("Cancel",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            )),
      ),
    );

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Time until wake up:",
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            formatHHMMSS((_timeLeft / 1000).round()),
            style: TextStyle(
              color: Color.fromARGB(
                  255,
                  (120 * cos(_timeLeft / 1000)).round() + 126,
                  130,
                  (120 * sin(_timeLeft / 1000)).round() + 126),
              fontSize: 50,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.8,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          _cancelButton,
        ],
      )),
    );
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
