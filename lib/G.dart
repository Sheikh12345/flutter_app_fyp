import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class G extends StatefulWidget {
  @override
  _GState createState() => _GState();
}

class _GState extends State<G> {
  @override
  final dbRef = FirebaseDatabase.instance.reference();
  bool value = false;
  Color color = Colors.grey;

  onUpdate() {
    setState(() {
      value = !value;
    });

  }
  static final GlobalKey<ScaffoldState> _scaffoldKey =
  new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return MaterialApp(      theme: ThemeData(
      brightness: Brightness.dark,
    ),
      debugShowCheckedModeBanner: false,
    );
  }
}
