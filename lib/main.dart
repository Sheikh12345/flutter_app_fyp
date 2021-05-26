import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';



import 'Screens/Auth/Welcome_screen.dart';
import 'graph.dart';
import 'homescreen.dart';

// ignore: unused_element
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //  theme: ThemeData(brightness: Brightness.dark),
      home:  Home(),
    );
  }
  nextScreen(){
try{
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User user) {
    if (user == null) {
      return WelcomePage();
    } else {

    }

    });
  }catch(e){
  print(e.toString());
  }}
}