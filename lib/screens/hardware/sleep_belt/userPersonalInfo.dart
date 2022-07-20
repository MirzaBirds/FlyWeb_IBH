import 'package:doctor_dreams/config/appColors.dart';
import 'package:flutter/material.dart';

class UserPersonalInfo extends StatefulWidget {
  const UserPersonalInfo({Key? key}) : super(key: key);

  @override
  State<UserPersonalInfo> createState() => _UserPersonalInfoState();
}

class _UserPersonalInfoState extends State<UserPersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.primary),
        titleTextStyle: TextStyle(color: AppColors.primary),
        title: Text(
          "User Personal Information",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: InkWell(
              onTap: () {},
              child: Container(
                color: AppColors.primary,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Gender",
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
                          "Male",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: AppColors.white),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,
                            color: AppColors.white),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: InkWell(
              onTap: () {},
              child: Container(
                color: AppColors.primary,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Height",
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
                          "30cm",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: AppColors.white),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,
                            color: AppColors.white),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: InkWell(
              onTap: () {},
              child: Container(
                color: AppColors.primary,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Weight",
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
                          "50kg",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: AppColors.white),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,
                            color: AppColors.white),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: InkWell(
              onTap: () {},
              child: Container(
                color: AppColors.primary,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Birthday",
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
                          "2022-07-10",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: AppColors.white),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,
                            color: AppColors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColors.secondary,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: () {

            },
            child: Text(
              "Save",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: AppColors.white),
            ),

          )
        ],
      ),
    );
  }
}
