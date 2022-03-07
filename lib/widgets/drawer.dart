import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/home.dart';
import 'package:doctor_dreams/screens/Auth/authScreen.dart';
import 'package:doctor_dreams/screens/ecommerce/user-details/account.dart';
import 'package:doctor_dreams/screens/ecommerce/user-details/orderHistory.dart';
import 'package:doctor_dreams/screens/hardware/pairDevice.dart';
import 'package:doctor_dreams/services/shopify/customerAuth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String getUserInfo = '';
  String getUserAccessToken = '';

  void initState() {
    getUserToken();
    super.initState();
  }

  Future<void> getUserToken() async {
    getUserInfo = await CustomerAuth().getUserData();
    print(getUserInfo);
    getUserAccessToken = await CustomerAuth().getUserAccessToken();
    print(getUserAccessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.app_drawer_2, AppColors.app_drawer_1])),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            (getUserAccessToken != "null")
                ? UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage("assets/user.png"),
                    ),
                    accountEmail: Text('abc@example.com'),
                    accountName: Text(
                      'Jane Doe',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      AppColors.app_drawer_2,
                      AppColors.app_drawer_1
                    ])),
                  )
                : UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage("assets/user.png"),
                    ),
                    accountEmail: Text('User Not Found.'),
                    accountName: Text(
                      'Please Login',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      AppColors.app_drawer_2,
                      AppColors.app_drawer_1
                    ])),
                  ),
            (getUserAccessToken != "null")
                ? loggedInMenu(context)
                : menu(context)
          ],
        ),
      ),
    );
  }

  Column loggedInMenu(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: AppColors.white,
          leading: const Icon(
            Icons.house,
            color: AppColors.white,
          ),
          title: const Text(
            'Home',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AuthScreen(),
              ),
            );
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.white,
        ),
        ListTile(
          leading: const Icon(Icons.devices, color: AppColors.white),
          title: const Text(
            'Devices',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => PairDevice(),
              ),
            );
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.white,
        ),
        ListTile(
          leading: const Icon(
            Icons.account_circle,
            color: AppColors.white,
          ),
          title: const Text(
            'Manage Account',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const Account(),
              ),
            );
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.white,
        ),
        ListTile(
          leading: const Icon(
            Icons.history,
            color: AppColors.white,
          ),
          title: const Text(
            'Order History',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const OrderHistory(),
              ),
            );
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.white,
        ),
        ListTile(
          leading: const Icon(
            Icons.help,
            color: AppColors.white,
          ),
          title: const Text(
            'Help',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const Home(),
              ),
            );
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.white,
        ),
        ListTile(
          leading: const Icon(
            Icons.device_unknown_sharp,
            color: AppColors.white,
          ),
          title: const Text(
            'About',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const Home(),
              ),
            );
          },
        ),
      ],
    );
  }

  Column menu(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: AppColors.white,
          leading: const Icon(
            Icons.house,
            color: AppColors.white,
          ),
          title: const Text(
            'Home',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AuthScreen(),
              ),
            );
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.white,
        ),
        ListTile(
          leading: const Icon(Icons.devices, color: AppColors.white),
          title: const Text(
            'Devices',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => PairDevice(),
              ),
            );
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.white,
        ),
        // ListTile(
        //   leading: const Icon(
        //     Icons.account_circle,
        //     color: AppColors.white,
        //   ),
        //   title: const Text(
        //     'Manage Account',
        //     style: TextStyle(fontSize: 16.00, color: AppColors.white),
        //   ),
        //   onTap: () {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute<void>(
        //         builder: (BuildContext context) => const Account(),
        //       ),
        //     );
        //   },
        // ),
        // const Divider(
        //   height: 10,
        //   thickness: 1,
        //   color: AppColors.white,
        // ),
        // ListTile(
        //   leading: const Icon(
        //     Icons.history,
        //     color: AppColors.white,
        //   ),
        //   title: const Text(
        //     'Order History',
        //     style: TextStyle(fontSize: 16.00, color: AppColors.white),
        //   ),
        //   onTap: () {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute<void>(
        //         builder: (BuildContext context) => const OrderHistory(),
        //       ),
        //     );
        //   },
        // ),
        // const Divider(
        //   height: 10,
        //   thickness: 1,
        //   color: AppColors.white,
        // ),
        ListTile(
          leading: const Icon(
            Icons.help,
            color: AppColors.white,
          ),
          title: const Text(
            'Help',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const Home(),
              ),
            );
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.white,
        ),
        ListTile(
          leading: const Icon(
            Icons.device_unknown_sharp,
            color: AppColors.white,
          ),
          title: const Text(
            'About',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const Home(),
              ),
            );
          },
        ),
      ],
    );
  }
}
