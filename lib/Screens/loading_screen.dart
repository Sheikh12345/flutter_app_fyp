import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fyp/models/daily_usage_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'daily_usage_graph.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin{
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  List<DailyUsageModel> _data;
  @override
  void initState() {
    super.initState();
    updateChatValues();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  SpinKitSquareCircle(
        color: Colors.white,
        size: 50.0,
        controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
      )
    );
  }

  void updateChatValues() {
    _databaseReference
        .child("usersdata")
        .child("BNUzWwEH8VfnpxAdzeN8p8L0PR23")
        .child("-MZqeb0NYf5kkCWXgDIF")
        .child("Flat Data")
        .child("Mainline")
        .child("forGraph")
        .child("TotalWaterConsumed").once().then((value){
      _data = [
        DailyUsageModel(usageValue: double.parse(value.value["afterOneHOur"].toString()??0), hours: "1", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterTwoHOur"].toString()??0), hours: "2", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterThreeHOur"].toString()??0), hours: "3", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterFourHOur"].toString()??0), hours: "4", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterFiveHOur"].toString()??0), hours: "5", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterSixHOur"].toString()??0), hours: "6", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterSevenHOur"].toString()??0), hours: "7", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterEightHOur"].toString()??0), hours: "8", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterEightHOur"].toString()??0), hours: "9", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterNineHOur"].toString()??0), hours: "10", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterTenHOur"].toString()??0), hours: "11", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterElevenHOur"].toString()??0), hours: "12", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterTwelveHOur"].toString()??0), hours: "13", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterThirteenHOur"].toString()??0), hours: "14", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterFourteenHOur"].toString()??0), hours: "15", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterFifteenHOur"].toString()??0), hours: "16", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterSixteenHOur"].toString()??0), hours: "17", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterSeventeenHOur"].toString()??0), hours: "18", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterEighteenHOur"].toString()??0), hours: "19", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterNineteenHOur"].toString()??0), hours: "20", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterTwentyOneHOur"].toString()??0), hours: "21", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterTwentyTwoHOur"].toString()??0), hours: "22", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterTwentyThreeHOur"].toString()??0), hours: "23", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterTwentyFourHOur"].toString()??0), hours: "24", color: charts.ColorUtil.fromDartColor(Colors.blue)),
      ];
    }).whenComplete((){

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>DailyUsage(
            data: _data,
          )));
    });
  }

}
