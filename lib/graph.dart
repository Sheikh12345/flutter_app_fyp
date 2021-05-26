import 'dart:async';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'homescreen.dart';
import 'monthly_graphy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'linearSales.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  TwilioFlutter twilioFlutter;
  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
        accountSid: 'AC86d1d6074ee566dea92bd7b9f6ba7aaa',
        authToken: '32265bf9ca1fb058aab1f77c1d4f3552',
        twilioNumber: '+16514139542');
    super.initState();
    getIntValuesSF();
  }
  void sendSms() async {
    twilioFlutter.sendSMS(
        toNumber: '+923161129756', messageBody: 'oye kanjar');
  }
  void sendwh()async{

    twilioFlutter.sendWhatsApp(toNumber : '+923212444600',
        messageBody : 'hello world');
  }
  String uid = FirebaseAuth.instance.currentUser.uid;

  Map<dynamic, dynamic> data;
  List<Map<String, dynamic>> listMap = [];
  var a = 0, b = 0,z=0,y, reslut=0;
  var flowMainline, flowRoom1,flowRoom3,flowRoom2, flowRoom1Result=0,flowRoom3Result=0,flowRoom2Result=0, flowMainlineResult=0;
  LinearSales linearSales;
  List<LinearSales> listLinearSales = [];
  String userName, address, flatno, mobileNumber, email, pin;

  var intValue;
  setIntValues(var value, var name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(name, value);
  }

 var room1Flow,room3Flow,room2Flow, mainlineFlow;
  var room1Water,room2Water,room3Water, mainlineWater, room1WaterReslut=0,room2WaterReslut=0 ,room3WaterReslut=0 ,mainlineWaterReslut=0;

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      room1Flow = prefs.getInt("room1Flow");
      room2Flow = prefs.getInt("room2Flow");
      room3Flow = prefs.getInt("room3Flow");

      mainlineFlow = prefs.getInt("mainlineFlow");
      intValue = prefs.getInt('dailyWaterConsumed');
      room1Water = prefs.getInt("room1Water");
      room3Water = prefs.getInt("room3Water");
      room2Water = prefs.getInt("room2Water");
      mainlineWater = prefs.getInt('mainlineWater');
    });
  }

var sum=0;
 var monthly = 0;
  void addMonthlyValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Timer(Duration(hours: 24), () {
      if (monthly != null) {
        setState(() {
          monthly = sum;
          print(monthly);
        });
        setIntValues(monthly, "monthly");
        monthly = prefs.getInt("monthly");
      } else {
        setState(() {
          monthly = sum;
        });
      }
    });
  }

  void removeDailyUsage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Timer(Duration(seconds: 10), () {
      prefs.remove('dailyWaterConsumed');
    });
  }

  @override
  //void initState() {
  //  getIntValuesSF();
 //   super.initState();
 // }

  @override
  Widget build(BuildContext context) {
    addMonthlyValue();
    getIntValuesSF();

    return Scaffold(appBar: AppBar(title: Text("Water details",),actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Home ()));
        },
      )
    ],),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance
            .reference()
            .child("usersdata")
            .child(uid)
            .onValue,
        builder: (ctx, snapShot) {
          if (snapShot.hasData) {
            getIntValuesSF();
            data = Map<String, dynamic>.from(snapShot.data.snapshot.value);
            if (data != null) {
              data.forEach((key, value) {
                getIntValuesSF();

                value.forEach((key, d) {
                  if (key == "Name") {
                    userName = d;
                  }
                  if (key == "Email") {
                    email = d;
                  }
                  if (key == "Address") {
                    address = d;
                  }
                  if (key == "Mobile No") {
                    mobileNumber = d;
                  }
                  if (key == "flat no") {
                    flatno = d;
                  }

                  // email = d["Email"];

                  if (key == "Flat Data") {
                    d.forEach((key, c) {
                      getIntValuesSF();

                      if (key == "DailyUsage") {
                        c.forEach((key, f) {
                          linearSales = LinearSales(f["hour"], f["waterUsage"]);

                          listLinearSales.add(linearSales);
                        });
                      }
                      if (key == "Room1") {
                        b = c["Total Water Consumed"];
                        flowRoom1 = c["Current Flow Rate"];

                        if (room1Flow == null) {
                          setIntValues(flowRoom1, "room1Flow");
                        }
                        if (room1Water == null) {
                          setIntValues(b, "room1Water");
                        }
                        getIntValuesSF();
                        if (room1Water != null) {
                          room1WaterReslut = room1Water + b;
                        }
                        if (room1Flow != null) {
                          flowRoom1Result = room1Flow + flowRoom1;
                        }
                      }
                      if (key == "Room2") {
                        z = c["Total Water Consumed"];
                        flowRoom2 = c["Current Flow Rate"];

                        if (room1Flow == null) {
                          setIntValues(flowRoom2, "room2Flow");
                        }
                        if (room2Water == null) {
                          setIntValues(z, "room2Water");
                        }
                        getIntValuesSF();
                        if (room2Water != null) {
                          room2WaterReslut = room1Water + z;
                        }

                        if (room2Flow != null) {
                          flowRoom2Result = room2Flow + flowRoom2;
                        }
                      }


                      if (key == "Mainline") {
                        a = c["Total Water Consumed"];
                        reslut = a + b+z;
                        if (intValue == null) {
                          setIntValues(reslut, "dailyWaterConsumed");
                          getIntValuesSF();
                        }
                        if (mainlineWater == null) {
                          setIntValues(a, "mainlineWater");
                        }
                        getIntValuesSF();
                        if (mainlineWater != null) {
                          mainlineWaterReslut = mainlineWater + a;
                        }
                        if (intValue != null) {
                          sum = intValue + reslut;
                        }

                        getIntValuesSF();

                        flowMainline = c["Current Flow Rate"];
                        if (mainlineFlow == null) {
                          setIntValues(flowMainline, "mainlineFlow");
                        }
                        if (mainlineFlow != null) {
                          flowMainlineResult = mainlineFlow + flowMainline;
                        }
                      }
                    });
                  }
                });
              });
            }
            return ListView(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                // Center(child: Text("User Details")),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    //  Text("UserName : $userName"),

                    // Text("Email : $email"),

                    // Text("Address : $address"),

                    //Text("Mobile Number  : $mobileNumber"),

                    //  Text("Flat No : $flatno"),
                  ],
                ),
                // SizedBox(
                //  height: 36.0,
                // ),
                // DailyGraph(listLinearSales),
                // SizedBox(
                //   height: 12.0,
                // ),

                //   Center(child: Text("Monthly Usage = $monthly")),

                // // Center(child: Text("Current Flow Rate Mainline = $a")),
                //  Center(child: Text("Total Water Consumed Total = $sum")),
                //  Center(
                //     child: Text(
                //        "Total Water Consumed Mainline = $mainlineWaterReslut")),
                //   Center(
                //    child:
                //   Text("Total Water Consumed Room1 = $room1WaterReslut")),
                //Center(
                //child:
                // Text("Total Water Consumed Room2 = $room2WaterReslut")),

              //  MonthlyGraph(reslut),
                // Center(
                //      child: Text("Current Flow Rate Room1 = $flowRoom1Result")),
                //   Center(
                //      child: Text("Current Flow Rate Room2 = $flowRoom2Result")),
                // Center(
                //    child: Text(
                //       "Current Flow Rate Mainline= $flowMainlineResult")),

                // SizedBox(
                //   height: 36.0,
                // ),
                Row(
                    children: [
                      Container(
                        child: CircleAvatar(radius: 70,child:Text("        $sum \n Monthly Water \n  Usage/litre ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),) ),

                      ),
                      Container(
                        child: CircleAvatar(radius: 70,child:Text("        $sum \n Daily Water \n  Usage/litre ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),) ),
                      ),]),

                Row(
                  children: [
                    Container(
                      child: CircleAvatar(radius: 70,child:Text("       $mainlineWaterReslut\n   Mainline \n Usage/litre ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),) ),
                    ),
                    Container(
                      child: CircleAvatar(radius: 70,child:Text("       $flowMainlineResult\n   Mainline \n Flow rate ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),) ),
                    ),
                    // Container(
                    //  child: CircleAvatar(radius: 60,child:Text("        $flowMainlineResult\n   Mainline \n Flow Rate ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),) ),
                    // ),



                  ],
                ),
                Row(children: [ Container(
                  child: CircleAvatar(radius: 70,child:Text("        $room1WaterReslut\n  Room1 \n Usage/litre ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),) ),
                ),
                  Container(
                    child: CircleAvatar(radius: 70,child:Text("      $flowRoom1Result\n  Room1 \n Flow rate ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),) ),
                  )

                ],),
                Row(children: [ Container(
                  child: CircleAvatar(radius: 70,child:Text("        $room2WaterReslut\n  Room2 \n Usage/litre ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),) ),
                ),
                  Container(
                    child: CircleAvatar(radius: 70,child:Text("      $flowRoom2Result\n  Room2 \n Flow rate ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),) ),
                  )
                ],

                ),
Row(
  children: [Container(

    child :TextButton(
      onPressed: sendwh,
     // tooltip: 'Send Sms',
      child: Icon(Icons.send),
    )
  )],
)
              ],

            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}