import 'dart:async';

import 'package:doctor_dreams/widgets/animated_chart/chart/animated_line_chart.dart';
import 'package:doctor_dreams/widgets/animated_chart/chart/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

import '../../../config/appColors.dart';
import '../../../database_setup/database.dart';
import '../../../database_setup/models/dataHistory.dart';
import '../../../utils.dart';
import '../../../widgets/appBar.dart';
import '../../../widgets/bottomNav.dart';
import '../../../widgets/drawer.dart';
import '../../../widgets/topNav.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ReportDeviceScreen extends StatefulWidget {
  final BluetoothDevice device;
  final List<BluetoothService> services;
  final Map<int, List<int>> readValues = new Map<int, List<int>>();

  ReportDeviceScreen({Key? key, required this.device, required this.services})
      : super(key: key);

  @override
  State<ReportDeviceScreen> createState() => _ReportDeviceScreenState();
}

class _ReportDeviceScreenState extends State<ReportDeviceScreen> {
  BluetoothService? tempservice;
  BluetoothCharacteristic? _nodifycharacteristic;
  BluetoothCharacteristic? _writecharacteristic;
  int comandKind = 0;
  late Timer timer;
  bool isConnected = false;
  List<List> dataSet = [];
  List<charts.Series<DataHistory, String>> _seriesDataBar = [];
  List<charts.Series<DataHistory, int>> _seriesDataLine = [];
  List<DataHistory> _listExep = [];
  Random random = new Random();
  final List<HeartRateModel> chartData = [];
  late Map<DateTime, double> lineChart;
  late LineChart chart;


  Map<DateTime, double> createLine2() {
    Map<DateTime, double> data = {};
    var date = DateTime.now().subtract(Duration(minutes: DateTime.now().minute));
    Random random = new Random();

    for(int i = 1; i< 50 ; i++)
    {
      data[date.subtract(Duration(minutes:  i))] =  double.parse((random.nextInt(40) + 40).toString() );
    }

    return data;
  }

  @override
  void initState() {
    super.initState();
    lineChart = createLine2();
    chart = LineChart.fromDateTimeMaps(
        [lineChart], [Colors.blue], ['bpm',],
        tapTextFontWeight: FontWeight.w400);

    print("Called===================");

    timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      print("Timer ");
      FlutterBlue.instance.connectedDevices.then((value) {
        if (value.length >= 1 && !isConnected) {
          _notification();
          isConnected = true;
        } else if (value.length == 0 && isConnected) {
          isConnected = false;
        }
      });
    });
    this.getUserData();
    for(int i = 1; i< 30 ; i++)
    {
      chartData.add( HeartRateModel(DateTime.now().subtract(Duration(minutes: i)), random.nextInt(80,)+40 ),);
    }
  }

  getUserData() {
    timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      // comandKind = 0;
      if (isConnected) {
        _sendCommand();
      }
      _addData(
          widget.readValues[0] != null
              ? getRealValueFromArray(widget.readValues[0]!)
              : [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          widget.readValues[0] != null
              ? getRealValueFromArray(widget.readValues[0]!).isNotEmpty
                  ? getRealValueFromArray(widget.readValues[0]!)[5]
                  : 1
              : 0);
    });
  }

  charts.Series<DataHistory, String> createSeriesBar(String id, int i) {
    return charts.Series<DataHistory, String>(
      id: id,
      domainFn: (DataHistory wear, _) {
        var str = wear.date;
        DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(str);
        //print("Vale ${tempDate.minute}");
        return tempDate.minute.toString();
      },
      measureFn: (DataHistory wear, _) => wear.value,
      data: [
        DataHistory(
          id: _listExep[i].id,
          value: _listExep[i].value,
          date: _listExep[i].date,
        ),
      ],
      fillPatternFn: (_, __) => charts.FillPatternType.solid,
      fillColorFn: (DataHistory pollution, _) =>
          charts.ColorUtil.fromDartColor(AppColors.primary),
    );
  }

  charts.Series<DataHistory, int> createSeriesLine(String id, int i) {
    return charts.Series<DataHistory, int>(
      id: id,
      domainFn: (DataHistory wear, _) {
        var str = wear.date;
        DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(str);
        //print("Vale ${tempDate.minute}");
        return tempDate.minute.toInt();
      },
      measureFn: (DataHistory wear, _) => wear.value,
      data: [
        DataHistory(
          id: _listExep[i].id,
          value: _listExep[i].value,
          date: _listExep[i].date,
        ),
      ],
    );
  }

  _generateData() async {
    await DBProvider.db.getOtherDetails().then((value) {
      print(value.length);
      setState(() {
        _listExep.clear();
        _listExep.addAll(value.reversed);
      });
      _seriesDataBar = <charts.Series<DataHistory, String>>[];
      _seriesDataLine = <charts.Series<DataHistory, int>>[];
      int index = value.length;
      if (index > 30) {
        index = 30;
      } else {
        index = value.length;
      }
      for (int i = 0; i < index; i++) {
        String id = '2022';
        // print("Data ${value[i]}");
        _seriesDataBar.add(createSeriesBar(id, i));
        _seriesDataLine.add(createSeriesLine(id, i));
      }
      setState(() {
        _seriesDataBar = _seriesDataBar;
        _seriesDataLine = _seriesDataLine;
      });
      String date = value[0].value.toString();
      setState(() {
        date = date;
        print("date $date");
      });
    });
  }

  _addData(List value, int index) async {
    print("_____________Data set length 129_______________");
    print(dataSet.length);
    print(index);
    print("_____________Data set length_______________");
    try {
      if (index == 0) {
        print("Clearing the data list");
        dataSet.clear();
      } else {
        dataSet.add(value);
      }
      print("_____________Data set length 138_______________");
      print(dataSet.length);
      print("_____________Data set length_______________");

      if (dataSet.length == 4) {
        for (int i = 0; i < dataSet.length; i++) {
          if (i == 0) {
            for (int j = 0; j < dataSet[i].length; j++) {
              if (j > 3) {
                print("----------------------------------------");
                print("Index Value ${dataSet[i][j]}");
                print("----------------------------------------");
                print("Index Value ${dataSet[j][i]}");
                /*await DBProvider.db.otherDetails(
                DataHistory(
                  id: DateTime.now().millisecondsSinceEpoch,
                  date: "${DateTime.now().toLocal()}",
                  value: random.nextInt(100),
                ),
              );*/
              }
            }
          } else {
            if (i == 0) {
              for (int j = 0; j < dataSet[i].length; j++) {
                print("Index Value ${dataSet[j][i]}");
                /*await DBProvider.db.otherDetails(
                DataHistory(
                  id: DateTime.now().millisecondsSinceEpoch,
                  date: "${DateTime.now().toLocal()}",
                  value: random.nextInt(100),
                ),
              );*/

              }
            }
          }
        }
      }

      await DBProvider.db.otherDetails(
        DataHistory(
          id: DateTime.now().millisecondsSinceEpoch,
          date: "${DateTime.now().toLocal()}",
          value: random.nextInt(90),
        ),
      );
    } catch (e) {
      print(e);
    }
    this._generateData();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {



    print("+++++++++++++++++++widget.readValues+++++line 125+++++++++++");
    print(widget.readValues);
    print("+++++++++++++++++++widget.readValues+++++line 125+++++++++++");
    return SafeArea(
      child: Scaffold(
        appBar: AppPrimaryBar(isSleetBelt: true),
        drawer: AppDrawer(),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TopNavBar(
                device: widget.device,
                services: widget.services,
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    TabBar(
                      indicatorColor: AppColors.primary,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      tabs: [
                        Tab(
                          text: "Day",
                        ),
                        Tab(
                          text: "Week",
                        ),
                        Tab(
                          text: "Month",
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                  child: Text(
                                    TimeUtils.dayFormat(DateTime.now()),
                                    style: TextStyle(
                                        color: AppColors.primary, fontSize: 25),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Stack(
                                  children: <Widget>[
                                    Center(
                                      child: CircularStepProgressIndicator(
                                        totalSteps: 50,
                                        currentStep: (widget.readValues[0] !=
                                                    null
                                                ? getRealValueFromArray(
                                                    widget.readValues[0]!)[3]
                                                : 0 / 2)
                                            .toInt(),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        selectedColor: AppColors.primary,
                                        unselectedColor:
                                            AppColors.secondary_light,
                                        selectedStepSize: 5.0,
                                        unselectedStepSize: 5.0,
                                        roundedCap: (_, isSelected) =>
                                            isSelected,
                                      ),
                                    ),
                                    Positioned(
                                      top: 50,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Text(
                                          widget.readValues[0] != null
                                              ? "Sleep Well"
                                              : "Sleep Well",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: AppColors.primary),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 170,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Text(
                                          "Rest Time",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: AppColors.primary),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 190,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Text(
                                          "${random.nextInt(8)}h:${random.nextInt(59)}min",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: AppColors.primary),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                const Divider(
                                  color: AppColors.primary,
                                  height: 2,
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/sleep_belt/ic_heart_pulse.png",
                                          color: AppColors.primary,
                                          height: 25,
                                          width: 25,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Average\nHeart Rate\n\n0Time/min",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: AppColors.primary),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/sleep_belt/ic_lungs.png",
                                          color: AppColors.primary,
                                          height: 25,
                                          width: 25,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Average\nBreath Rate\n\n0Time/min",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: AppColors.primary),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/sleep_belt/ic_bed_time.png",
                                          color: AppColors.primary,
                                          height: 30,
                                          width: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Fall\nAsleep Rate\n\n0min",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: AppColors.primary),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  color: AppColors.primary,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      "Heart Rate",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: AppColors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 20),
                                  height: 350,
                                  width: MediaQuery.of(context).size.width,

                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 5.0),
                                    child: ChartData(),  /*SfCartesianChart(
                                        primaryXAxis: DateTimeAxis(),
                                        // Chart title
                                        // Enable legend
                                        // Enable tooltip
                                        tooltipBehavior: TooltipBehavior(enable: true),
                                        series: <ChartSeries>[
                                        // Renders line chart
                                        LineSeries<HeartRateModel, DateTime>(
                                        dataSource: chartData,
                                        xValueMapper: (HeartRateModel sales, _) => sales.time,
                                        yValueMapper: (HeartRateModel sales, _) => sales.rate
                                    ),]),*/ /*charts.BarChart(
                                      _seriesDataBar,
                                      animate: false,
                                      barGroupingType:
                                          charts.BarGroupingType.grouped,
                                      //behaviors: [new charts.SeriesLegend()],
                                      animationDuration: Duration(seconds: 3),
                                      domainAxis: new charts.OrdinalAxisSpec(
                                        renderSpec:
                                            new charts.SmallTickRendererSpec(
                                          // Tick and Label styling here.
                                          labelStyle: new charts.TextStyleSpec(
                                            fontSize: 10, // size in Pts.
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                          // Change the line colors to match text color.
                                          lineStyle: new charts.LineStyleSpec(
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                        ),
                                      ),
                                      primaryMeasureAxis:
                                          new charts.NumericAxisSpec(
                                        renderSpec:
                                            new charts.GridlineRendererSpec(
                                          // Tick and Label styling here.
                                          labelStyle: new charts.TextStyleSpec(
                                            fontSize: 11, // size in Pts.
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),

                                          // Change the line colors to match text color.
                                          lineStyle: new charts.LineStyleSpec(
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                        ),
                                      ),
                                    ),*/
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  color: AppColors.primary,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      "Breath Rate",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: AppColors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 20),
                                  height: 350,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 5.0),
                                    child: charts.BarChart(
                                      _seriesDataBar,
                                      animate: false,
                                      barGroupingType:
                                          charts.BarGroupingType.grouped,
                                      //behaviors: [new charts.SeriesLegend()],
                                      animationDuration: Duration(seconds: 3),
                                      domainAxis: new charts.OrdinalAxisSpec(
                                        renderSpec:
                                            new charts.SmallTickRendererSpec(
                                          // Tick and Label styling here.
                                          labelStyle: new charts.TextStyleSpec(
                                            fontSize: 10, // size in Pts.
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                          // Change the line colors to match text color.
                                          lineStyle: new charts.LineStyleSpec(
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                        ),
                                      ),
                                      primaryMeasureAxis:
                                          new charts.NumericAxisSpec(
                                        renderSpec:
                                            new charts.GridlineRendererSpec(
                                          // Tick and Label styling here.
                                          labelStyle: new charts.TextStyleSpec(
                                            fontSize: 11, // size in Pts.
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),

                                          // Change the line colors to match text color.
                                          lineStyle: new charts.LineStyleSpec(
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  color: AppColors.primary,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      "Sleep Details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: AppColors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 20),
                                  height: 350,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 5.0),
                                    child: charts.BarChart(
                                      _seriesDataBar,
                                      animate: false,
                                      barGroupingType:
                                          charts.BarGroupingType.grouped,
                                      //behaviors: [new charts.SeriesLegend()],
                                      animationDuration: Duration(seconds: 3),
                                      domainAxis: new charts.OrdinalAxisSpec(
                                        renderSpec:
                                            new charts.SmallTickRendererSpec(
                                          // Tick and Label styling here.
                                          labelStyle: new charts.TextStyleSpec(
                                            fontSize: 10, // size in Pts.
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                          // Change the line colors to match text color.
                                          lineStyle: new charts.LineStyleSpec(
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                        ),
                                      ),
                                      primaryMeasureAxis:
                                          new charts.NumericAxisSpec(
                                        renderSpec:
                                            new charts.GridlineRendererSpec(
                                          // Tick and Label styling here.
                                          labelStyle: new charts.TextStyleSpec(
                                            fontSize: 11, // size in Pts.
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),

                                          // Change the line colors to match text color.
                                          lineStyle: new charts.LineStyleSpec(
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  color: AppColors.primary,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      "Heart Rate",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: AppColors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 20),
                                  height: 350,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 5.0),
                                    child: charts.BarChart(
                                      _seriesDataBar,
                                      vertical: false,
                                      animate: false,
                                      barGroupingType:
                                      charts.BarGroupingType.grouped,
                                      //behaviors: [new charts.SeriesLegend()],
                                      animationDuration: Duration(seconds: 3),
                                      domainAxis: new charts.OrdinalAxisSpec(
                                        renderSpec:
                                        new charts.SmallTickRendererSpec(
                                          // Tick and Label styling here.
                                          labelStyle: new charts.TextStyleSpec(
                                            fontSize: 10, // size in Pts.
                                            color:
                                            charts.ColorUtil.fromDartColor(
                                                AppColors.secondary),
                                          ),
                                          // Change the line colors to match text color.
                                          lineStyle: new charts.LineStyleSpec(
                                            color:
                                            charts.ColorUtil.fromDartColor(
                                                AppColors.secondary),
                                          ),
                                        ),
                                      ),
                                      primaryMeasureAxis:
                                      new charts.NumericAxisSpec(
                                        renderSpec:
                                        new charts.GridlineRendererSpec(
                                          // Tick and Label styling here.
                                          labelStyle: new charts.TextStyleSpec(
                                            fontSize: 11, // size in Pts.
                                            color:
                                            charts.ColorUtil.fromDartColor(
                                                AppColors.secondary),
                                          ),

                                          // Change the line colors to match text color.
                                          lineStyle: new charts.LineStyleSpec(
                                            color:
                                            charts.ColorUtil.fromDartColor(
                                                AppColors.secondary),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  color: AppColors.primary,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      "Breath Rate",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: AppColors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 20),
                                  height: 350,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 5.0),
                                    child: charts.BarChart(
                                      _seriesDataBar,
                                      animate: false,
                                      barGroupingType:
                                          charts.BarGroupingType.grouped,
                                      //behaviors: [new charts.SeriesLegend()],
                                      animationDuration: Duration(seconds: 3),
                                      domainAxis: new charts.OrdinalAxisSpec(
                                        renderSpec:
                                            new charts.SmallTickRendererSpec(
                                          // Tick and Label styling here.
                                          labelStyle: new charts.TextStyleSpec(
                                            fontSize: 10, // size in Pts.
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                          // Change the line colors to match text color.
                                          lineStyle: new charts.LineStyleSpec(
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                        ),
                                      ),
                                      primaryMeasureAxis:
                                          new charts.NumericAxisSpec(
                                        renderSpec:
                                            new charts.GridlineRendererSpec(
                                          // Tick and Label styling here.
                                          labelStyle: new charts.TextStyleSpec(
                                            fontSize: 11, // size in Pts.
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),

                                          // Change the line colors to match text color.
                                          lineStyle: new charts.LineStyleSpec(
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  color: AppColors.primary,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      "Sleep Details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: AppColors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 20),
                                  height: 350,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 5.0),
                                    child: charts.BarChart(
                                      _seriesDataBar,
                                      animate: false,
                                      barGroupingType:
                                          charts.BarGroupingType.grouped,
                                      //behaviors: [new charts.SeriesLegend()],
                                      animationDuration: Duration(seconds: 3),
                                      domainAxis: new charts.OrdinalAxisSpec(
                                        renderSpec:
                                            new charts.SmallTickRendererSpec(
                                          // Tick and Label styling here.
                                          labelStyle: new charts.TextStyleSpec(
                                            fontSize: 10, // size in Pts.
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                          // Change the line colors to match text color.
                                          lineStyle: new charts.LineStyleSpec(
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                        ),
                                      ),
                                      primaryMeasureAxis:
                                          new charts.NumericAxisSpec(
                                        renderSpec:
                                            new charts.GridlineRendererSpec(
                                          // Tick and Label styling here.
                                          labelStyle: new charts.TextStyleSpec(
                                            fontSize: 11, // size in Pts.
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),

                                          // Change the line colors to match text color.
                                          lineStyle: new charts.LineStyleSpec(
                                            color:
                                                charts.ColorUtil.fromDartColor(
                                                    AppColors.secondary),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            widget.readValues[0] != null
                                ? "Sleep Well"
                                : "Sleep Well",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                    /* WakeupList(_sleepDuration, _averageSleep, _sleepGoToBed,
                    _averageGoToBed, _sleepWakeup, _averageWakeup),*/
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }

  Future<void> _notification() async {
    tempservice = widget.services[2];
    for (BluetoothCharacteristic characteristic
        in tempservice!.characteristics) {
      if (characteristic.properties.write)
        _writecharacteristic = characteristic;
      if (characteristic.properties.notify)
        _nodifycharacteristic = characteristic;
    }
    _nodifycharacteristic?.value.listen((value) {
      if (mounted)
        setState(() {
          switch (comandKind) {
            case 0:
              widget.readValues[0] = value;
              break;
            // case 1:
            //   widget.readValues[1] = value;
            //   break;
            // case 2:
            //   widget.readValues[2] = value;
            //   break;
            // case 3:
            //   widget.readValues[3] = value;
            //   break;
            // case 4:
            //   widget.readValues[4] = value;
            //   break;
            // case 5:
            //   widget.readValues[5] = value;
            //   break;
            // case 6:
            //   widget.readValues[6] = value;
            //   break;
            // case 7:
            //   widget.readValues[7] = value;
            //   break;
          }
        });
    });
    await _nodifycharacteristic?.setNotifyValue(true);
  }

  Future<void> _sendCommand() async {
    print("Device Connecting State value is $isConnected");

    comandKind++;
    if (comandKind == 1) comandKind = 0;
    print("+++++++++++++++++++comandKind++++++++++++++++++++++++++");
    print(comandKind);
    switch (comandKind) {
      case 0:
        await _writecharacteristic?.write(getHeartRateBreathing());
        break;
      // case 1:
      //   await _writecharacteristic!.write(getRealTimeHeartRate());
      //   break;
      /*case 2:
        await _writecharacteristic.write(_buildChargeBotCommand(1, 81));
        break;
      case 3:
        await _writecharacteristic.write(_buildChargeBotCommand(1, 82));
        break;
      case 4:
        await _writecharacteristic.write(_buildChargeBotCommand(1, 87));
        break;
      case 5:
        await _writecharacteristic.write(_buildChargeBotCommand(1, 88));
        break;
      case 6:
        await _writecharacteristic.write(_buildChargeBotCommand(1, 89));
        break;
      case 7:
        await _writecharacteristic.write(_buildChargeBotCommand(1, 93));
        break;*/
    }
  }

  List<int> getRealValueFromArray(List<int> data) {
    print("+++++++++++++++++++++++++++++");
    print(data);
    print("+++++++++++++++++++++++++++++");
    // if (data == null) return 0;
    // List<int> temp = <int>[];
    // temp = data;
    // if (temp == null) return 0;
    if (data.isEmpty)
      return [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ];
    else {
      // return (temp[3] << 8) + temp[4];
      return data;
    }
    return data;
  }

  List<int> _buildChargeBotCommand(int command1, int command2) {
    List<int> cmd = <int>[];
    cmd.add(170);
    cmd.add(command1);
    cmd.add(command2);
    cmd.add(0);
    cmd.add(0);
    return cmd;
  }

  //
  static int _getBcdValue(int value) {
    String data = value.toString();
    if (data.length > 2) data = data.substring(2);
    return int.parse(data, radix: 16);
  }

  /// crc validation
  static void crcValue(List<int> list) {
    int crcValue = 0;
    for (final int value in list) {
      crcValue += value;
    }
    list[15] = crcValue & 0xff;

    print("CRC value for ${list[1]} : ${crcValue}");
  }

  static List<int> generateValue(int size) {
    final List<int> value = List<int>.generate(size, (int index) {
      return 0;
    });
    return value;
  }

  static List<int> _generateInitValue() {
    return generateValue(16);
  }

  static List<int> _setPersonalInfo(
      int gender, int age, int height, int weight) {
    final List<int> value = _generateInitValue(); //16
    value[0] = 0x01;
    value[1] = _getBcdValue(gender);
    value[2] = _getBcdValue(age);
    value[3] = _getBcdValue(height);
    value[4] = _getBcdValue(weight);
    crcValue(value);
    return value;
  }

  static List<int> setDeviceTime() {
    final List<int> value = _generateInitValue(); //16
    final int year = DateTime.now().year;
    final int month = DateTime.now().month;
    final int day = DateTime.now().day;
    final int hour = DateTime.now().hour;
    final int minute = DateTime.now().minute;
    final int second = DateTime.now().second;
    value[0] = 0x01;
    value[1] = _getBcdValue(year);
    value[2] = _getBcdValue(month);
    value[3] = _getBcdValue(day);
    value[4] = _getBcdValue(hour);
    value[5] = _getBcdValue(minute);
    value[6] = _getBcdValue(second);
    crcValue(value);
    return value;
  }

  static List<int> getRealTimeHeartRate() {
    final List<int> value = _generateInitValue(); //16
    final int AA = 1;
    value[0] = 0x11;
    value[1] = _getBcdValue(AA);
    crcValue(value);
    return value;
  }

  static List<int> getPowerDevice() {
    final List<int> value = _generateInitValue(); //16
    final int AA = 1;
    value[0] = 0xd;
    value[1] = _getBcdValue(AA);
    crcValue(value);
    return value;
  }

  static List<int> getHeartRateBreathing() {
    final List<int> value = _generateInitValue(); //16
    final int AA = 1;
    value[0] = 0x17;
    value[1] = _getBcdValue(AA);
    crcValue(value);
    return value;
  }
}
class HeartRateModel {
  HeartRateModel(this.time, this.rate);
  final DateTime time;
  final int rate;
}
class ChartData extends StatelessWidget {
   ChartData({Key? key}) : super(key: key);
  late Map<DateTime, double> lineChart;
  late LineChart chart;


  Map<DateTime, double> createLine2() {
    Map<DateTime, double> data = {};
    var date = DateTime.now().subtract(Duration(minutes: DateTime.now().minute));
    Random random = new Random();

    for(int i = 1; i< 50 ; i++)
    {
      data[date.subtract(Duration(minutes:  i))] =  double.parse((random.nextInt(40) + 40).toString() );
    }

    return data;
  }
  @override
  Widget build(BuildContext context) {
    lineChart = createLine2();
    chart = LineChart.fromDateTimeMaps(
        [lineChart], [Colors.blue], ['',],
        tapTextFontWeight: FontWeight.w400);

    return  AnimatedLineChart(
      chart,
      key: UniqueKey(),
      gridColor: Colors.black54,
      textStyle: TextStyle(fontSize: 10, color: Colors.black54),
      toolTipColor: Colors.white,
    );
  }
}
