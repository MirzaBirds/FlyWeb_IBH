import 'package:doctor_dreams/screens/hardware/sleep_belt/pairDeviceScreen.dart';
import 'package:doctor_dreams/screens/hardware/sleep_belt/userPersonalInfo.dart';
import 'package:flutter/material.dart';

import '../../../config/appColors.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({Key? key}) : super(key: key);

  @override
  State<AccountManagementScreen> createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagementScreen> {
  List listTitle = [
    "Pair Device",
    "Battery Level",
    "User Personal Information"
  ];
  List listIcons = [
    Icons.perm_device_info,
    Icons.battery_charging_full_rounded,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Icon(
                    Icons.person,
                    size: 40,
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                "Abcd",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: AppColors.primary),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                itemCount: listTitle.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: InkWell(
                      onTap: () {
                        if (listTitle[index] == "Pair Device") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PairDeviceScreen()));
                        } else if (listTitle[index] == "Battery Level") {
                        } else if (listTitle[index] ==
                            "User Personal Information") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPersonalInfo()));
                        }
                      },
                      child: Container(
                        color: AppColors.primary,
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(listIcons[index], color: AppColors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  listTitle[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: AppColors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: AppColors.primary),
                                ),
                                Icon(Icons.arrow_forward_ios_outlined,
                                    color: AppColors.white),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
