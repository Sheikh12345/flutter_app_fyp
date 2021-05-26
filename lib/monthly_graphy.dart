import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'daily_graphy.dart';

class MonthlyGraph extends StatefulWidget {
  final int value;
  MonthlyGraph(this.value);
  @override
  _MonthlyGraphState createState() => _MonthlyGraphState();
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _MonthlyGraphState extends State<MonthlyGraph> {
  @override
  Widget build(BuildContext context) {
    var data = [
      ClicksPerYear(
          " ${DateTime.now().month.toString()}-${DateTime.now().day.toString()}-${DateTime.now().year.toString()}",
          widget.value,
          Colors.red),
      ClicksPerYear("Mon 4-19-2021", 0, Colors.yellow),
      ClicksPerYear("Tues 4-20-2021", 0, Colors.green),
    ];

    var series = [
      charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: false,
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Monthly Water Usage"),
        SizedBox(
          height: 36.0,
        ),
        chartWidget,
      ],
    );
  }
}
