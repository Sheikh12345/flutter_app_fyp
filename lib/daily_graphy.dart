import 'linearSales.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DailyGraph extends StatefulWidget {
  /// Creates a [LineChart] with sample data and no transition.
  List<LinearSales> list;

  DailyGraph(this.list);

  @override
  _DailyGraphState createState() => _DailyGraphState();
}

class _DailyGraphState extends State<DailyGraph> {
  @override
  Widget build(BuildContext context) {

    var series = [
      new charts.Series<LinearSales,int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: widget.list,
      )
    ];

    var chart = charts.LineChart(series,
        animate: false,
        defaultRenderer: new charts.LineRendererConfig(includePoints: true));
    var chartWidget = Padding(
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        height: 200.0,
        child: chart,
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Daily Water Usage"),
        SizedBox(
          height: 36.0,
        ),
        chartWidget,
      ],
    );
  }
}

/// Sample linear data type.
