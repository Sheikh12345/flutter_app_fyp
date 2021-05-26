import 'package:flutter/material.dart';
import 'package:flutter_app_fyp/models/daily_usage_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class DailyUsage extends StatelessWidget {
  final List<DailyUsageModel> data;
  final String totalValueConsumed;
  DailyUsage({Key key, this.data, this.totalValueConsumed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<charts.Series<DailyUsageModel,String>> series = [
      charts.Series(
          id: "Usage",
          data: data,
          domainFn: (DailyUsageModel model,_)=> model.hours,
          measureFn: (DailyUsageModel model,_) => model.usageValue,
          colorFn: (DailyUsageModel model,_) => model.color
      )
    ];
    return SafeArea(
        child: Scaffold(
          body: Column(

            children: [
              SizedBox(
                height: size.height*0.02,
              ),
              Text("Daily Usage Graph",style:TextStyle(
                  color: Colors.blue,
                  fontSize: size.width*0.06,
                  fontWeight: FontWeight.w600
              ),),
              Expanded(child: charts.BarChart(
                series,
                animate: true,
              )),
              SizedBox(
                height: size.height*0.01,
              ),
              Text("Total consumer water: $totalValueConsumed",style:TextStyle(
                  color: Colors.blue,
                  fontSize: size.width*0.06,
                  fontWeight: FontWeight.w600
              ),),
              SizedBox(
                height: size.height*0.02,
              ),
            ],
          ),
        ));
  }
}
