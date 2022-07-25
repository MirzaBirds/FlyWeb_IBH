import 'dart:convert';

import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/config/graphql.dart';
import 'package:doctor_dreams/home.dart';
import 'package:doctor_dreams/screens/Auth/authScreen.dart';
import 'package:doctor_dreams/screens/Auth/login.dart';
import 'package:doctor_dreams/screens/ecommerce/user-details/account.dart';
import 'package:doctor_dreams/screens/ecommerce/user-details/orderHistory.dart';
import 'package:doctor_dreams/screens/hardware/pairDevice.dart';
import 'package:doctor_dreams/screens/hardware/pairDevice1.dart';
import 'package:doctor_dreams/screens/hardware/sleep_belt/monitorDevice.dart';
import 'package:doctor_dreams/services/shopify/customerAuth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/hardware/sleep_belt/yourDevices.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String getUserInfo = '';
  var getUserAccessToken;
  var userData;
  bool isToken = false;
  final GraphQLClient _client = getGraphQLClient();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  void initState() {
    getUserData();

    super.initState();
  }

  Future<void> getUserData() async {
    var getUserInfo = json.decode(await CustomerAuth().getUserData());
    print("++++++++++++++++++++++user Data++++++++++++++++++++");
    print(getUserInfo);
    setState(() {
      userData = getUserInfo;
    });
    // print(getUserInfo);
    //print(json.decode(getUserInfo).runtimeType);
    // print("++++++++++++++++++++++user Data++++++++++++++++++++");

    if (getUserInfo == null) {
      // print("++++++++++++++++++++++ DATA is NULL++++++++++++++++++++");
      setState(() {
        this.isToken = false;
      });
    } else {
      // print("++++++++++++++++++++++ DATA PRESENT++++++++++++++++++++");
      setState(() {
        this.isToken = true;
      });
    }
    // return getUserInfo;
  }

  // Future<void> getUserToken() async {
  //   getUserInfo = await CustomerAuth().getUserData();
  //   print(getUserInfo);
  //   getUserAccessToken = await CustomerAuth().getUserAccessToken();
  //   print("++ Token value ++");
  //   print(getUserAccessToken.runtimeType);
  //   print("checking condition about token");
  //   print(getUserAccessToken == null);
  //   if (getUserAccessToken == null) {
  //     print("+++++++++++++++++++++token null++++++++++++++++++++");

  //     setState(() {
  //       this.isToken = false;
  //     });
  //   } else {
  //     print("++++++++++++++++++++token present+++++++++++++++++++++++++");
  //     // userData = json.decode(await CustomerAuth().getUserData());
  //     // print("++ User Data........ ++");
  //     // print(userData);
  //     setState(() {
  //       this.isToken = true;
  //     });
  //   }
  //   return getUserAccessToken;
  // }

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
            this.isToken
                ? UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage("assets/user.png"),
                    ),
                    accountEmail: Text("${this.userData?['email']}"),
                    accountName: Text(
                      "${this.userData?['firstName']} ${this.userData?['lastName']}",
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
                    accountEmail: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => AuthScreen(),
                          ),
                        );
                      },
                      child: Text('Login'),
                    ),
                    accountName: Text(
                      '',
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      AppColors.app_drawer_2,
                      AppColors.app_drawer_1
                    ])),
                  ),
            this.isToken ? loggedInMenu(context) : menu(context)
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
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    this.isToken ? Home() : AuthScreen(),
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
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => PairDevice1(),
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
            'Doctor Dreams Account',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const Account(),
              ),
            );
          },
        ),
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
          onTap: () async {
            await launch('https://doctordreams.com/pages/contact-us');
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
          onTap: () async {
            await launch(
                'https://doctordreams.com/pages/doctordreams-by-nilkamal-about-us');
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.white,
        ),
        ListTile(
          leading: const Icon(
            Icons.privacy_tip,
            color: AppColors.white,
          ),
          title: const Text(
            'Privacy Policy',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () async {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute<void>(
            //     builder: (BuildContext context) => const Home(),
            //   ),
            // );
            await launch('https://doctordreams.com/pages/privacy-policy');
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.white,
        ),
        ListTile(
          tileColor: AppColors.white,
          leading: const Icon(
            Icons.logout,
            color: AppColors.white,
          ),
          title: const Text(
            'Logout for Doctor Dreams',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () async {
            bool status = await CustomerAuth().removeUserAccessTokenAndData();

            if (status) {
              print("logout successful....");
              setState(() {
                this.isToken = false;
              });
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => AuthScreen(),
                ),
              );
            }
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.white,
        ),
        ListTile(
          tileColor: AppColors.white,
          leading: const Icon(
            Icons.delete,
            color: AppColors.white,
          ),
          title: const Text(
            'Logout for Doctor Dreams Account',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () async {
            // bool status = await CustomerAuth().removeUserAccessTokenAndData();
            deleteAccountAlert(context, "");
            // if (status) {
            //   print("logout successful....");
            //   setState(() {
            //     this.isToken = false;
            //   });
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute<void>(
            //       builder: (BuildContext context) => AuthScreen(),
            //     ),
            //   );
            // }
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.white,
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
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    this.isToken ? Home() : AuthScreen(),
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
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => PairDevice1(),
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
          onTap: () async {
            await launch('https://doctordreams.com/pages/contact-us');
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
          onTap: () async {
            await launch(
                'https://doctordreams.com/pages/doctordreams-by-nilkamal-about-us');
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.white,
        ),
        ListTile(
          leading: const Icon(
            Icons.privacy_tip,
            color: AppColors.white,
          ),
          title: const Text(
            'Privacy Policy',
            style: TextStyle(fontSize: 16.00, color: AppColors.white),
          ),
          onTap: () async {
            await launch('https://doctordreams.com/pages/privacy-policy');
          },
        ),
      ],
    );
  }

  //

  deleteAccountAlert(BuildContext context, msg) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('''Do you want to delete doctor dreams account ?'''),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: Text('Yes'),
                  onPressed: () async {
                    print("Call delete Api");

                    // _deleteAccount();
                    print("Print : in deleted account........");
                    print("gid://shopify/Customer/${this.userData?['id']}");
                    print("Print : in deleted account........");
                    // final MutationOptions options = MutationOptions(
                    //   document: gql(CustomerAuth.deleteAccount),
                    //   variables: <String, dynamic>{"id": this.userData?['id']},
                    // );

                    final MutationOptions options = MutationOptions(
                      document: gql(CustomerAuth.deleteAccount),
                      variables: <String, dynamic>{
                        "id": "gid://shopify/Customer/${this.userData?['id']}"
                      },
                    );

                    final QueryResult result = await _client.mutate(options);
                    print(result);
                    // if (result.hasException) {
                    //   print(result.exception.toString());
                    //   return;
                    // }

                    bool status =
                        await CustomerAuth().removeUserAccessTokenAndData();

                    if (status) {
                      print("logout successful....");
                      setState(() {
                        this.isToken = false;
                      });
                      Navigator.of(context).pop();

                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => AuthScreen(),
                        ),
                      );
                    }
                  }),
              MaterialButton(
                  elevation: 5.0,
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }
}

// _deletAccount() async {}
