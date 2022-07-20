import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/utilities/my_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPersonalInfo extends StatefulWidget {
  const UserPersonalInfo({Key? key}) : super(key: key);

  @override
  State<UserPersonalInfo> createState() => _UserPersonalInfoState();
}

class _UserPersonalInfoState extends State<UserPersonalInfo> {
  String _selectedGenderValue = "Select Gender";
  String _selectedHeightValue = "Select Height";
  String _selectedWeightValue = "Select Weight";
  String _selectedBirthdayValue = "Select DD-MM-YYYY";

  @override
  void initState() {
    super.initState();
    _getValues();
  }

  _getValues() async {
    if (await MyPreference.getStringToSF(MyPreference.gender) != null) {
      _selectedGenderValue =
          await MyPreference.getStringToSF(MyPreference.gender);
    }
    if (await MyPreference.getStringToSF(MyPreference.height) != null) {
      _selectedHeightValue =
          await MyPreference.getStringToSF(MyPreference.height);
    }
    if (await MyPreference.getStringToSF(MyPreference.weight) != null) {
      _selectedWeightValue =
          await MyPreference.getStringToSF(MyPreference.weight);
    }
    if (await MyPreference.getStringToSF(MyPreference.birthday) != null) {
      _selectedBirthdayValue =
          await MyPreference.getStringToSF(MyPreference.birthday);
    }

    setState(() {});
  }

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
              onTap: () {
                showPicker("Gender", [
                  Text(
                    "Female",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: AppColors.primary),
                  ),
                  Text(
                    "Male",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: AppColors.primary),
                  ),
                ]);
              },
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
                          _selectedGenderValue,
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
              onTap: () {
                List<Widget> list = [];
                for (int i = 30; i < 231; i++) {
                  list.add(Text(
                    "${i} cm",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: AppColors.primary),
                  ));
                }
                showPicker("Height", list);
              },
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
                          _selectedHeightValue,
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
              onTap: () {
                List<Widget> list = [];
                for (int i = 3; i < 220; i++) {
                  list.add(Text(
                    "${i} kg",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: AppColors.primary),
                  ));
                }
                showPicker("Weight", list);
              },
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
                          _selectedWeightValue,
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
              onTap: () {
                showPickerDate();
              },
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
                          _selectedBirthdayValue,
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
          Visibility(
            visible: false,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.secondary,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              ),
              onPressed: () {},
              child: Text(
                "Save",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: AppColors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  showPicker(String titleValue, List<Widget> widgetList) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: Column(
              children: [
                Container(
                  color: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            color: AppColors.primary,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Flexible(
                        child: Text(
                          "Gender",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.primary),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.done,
                            color: AppColors.primary,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 32,
                    scrollController:
                        FixedExtentScrollController(initialItem: 0),
                    children: widgetList,
                    onSelectedItemChanged: (value) {
                      setState(() {
                        print(value);
                        if (titleValue == "Gender") {
                          if (value == 0) {
                            MyPreference.addStringToSF(
                                MyPreference.gender, "Female");
                            _selectedGenderValue = "Female";
                          } else {
                            MyPreference.addStringToSF(
                                MyPreference.gender, "Male");
                            _selectedGenderValue = "Male";
                          }
                        } else if (titleValue == "Height") {
                          MyPreference.addStringToSF(
                              MyPreference.height, "${value + 30} cm");
                          _selectedHeightValue = "${value + 30} cm";
                        } else if (titleValue == "Weight") {
                          MyPreference.addStringToSF(
                              MyPreference.weight, "${value + 3} kg");
                          _selectedWeightValue = "${value + 3} kg";
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  showPickerDate() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            child: Column(
              children: [
                Container(
                  color: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            color: AppColors.primary,
                          ),
                          onPressed: () {}),
                      Flexible(
                        child: Text(
                          "Gender",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.primary),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.done,
                            color: AppColors.primary,
                          ),
                          onPressed: () {
                            //Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 200,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: AppColors.primary),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime(1969, 1, 1),
                        onDateTimeChanged: (DateTime newDateTime) {
                          // Do something
                          setState((){
                            _selectedBirthdayValue = "${newDateTime.day}-${newDateTime.month}-${newDateTime.year}";
                          });
                          MyPreference.addStringToSF(
                              MyPreference.birthday, "${newDateTime.day}-${newDateTime.month}-${newDateTime.year}");
                          print(newDateTime);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
