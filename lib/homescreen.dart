


import 'package:flutter_app_fyp/Screens/daily_usage_graph.dart';
import 'package:flutter_app_fyp/models/daily_usage_model.dart';

import 'G.dart';
import 'contact_us.dart';
import 'graph.dart';
import 'profilescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'db.dart';
import 'setting_screen.dart';
import 'Screens/Auth/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  List<DailyUsageModel> _data;




  String userName, address, flatno, mobileNumber, email, pin;
  // ignore: unused_field
  final _auth = FirebaseAuth.instance;
  // ignore: non_constant_identifier_names
  String UserId = '';
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<Posts> postList = [];

  currentUser() {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid.toString();
    return uid;
  }


  String flatnoflowRate, totalLitres;
  List<DataSnapshot> result;
  Map<String, dynamic> myMap;
  List<Map<String, dynamic>> listMap = [];
  void getUserData() async {
    final User user = FirebaseAuth.instance.currentUser;

    Query needsSnapshot = FirebaseDatabase.instance
        .reference()
        .child("usersdata")
        .child(user.uid)
        .orderByKey();

    needsSnapshot.once().then((value) => {
      myMap = new Map<String, dynamic>.from(value.value),
      setState(() {
        listMap.add(myMap);
      }),

    });

  }
  static double v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16,v17,v18,v19,v20,
      v21,v22,v23,v24;

  void initState() {
    super.initState();
    getUserData();
  }




  Widget build(BuildContext context) {
    listMap.forEach((Map<String, dynamic> element) {
      element.forEach((key, value) {
        if (key == "flat NO:1") {
          flatnoflowRate = value["Room"]["Flat No:1 Room 1 FlowRate Update"];
          totalLitres =
          value["Room"]["Flat No:1 Room1 TotalLitres Consumed Update"];
        }
        if (key != "flat NO:1") {
          setState(() {
            email = value["Email"];
            flatno = value["flat no"];
            mobileNumber = value["Mobile No"];
            userName = value["Name"];
            address = value["Address"];
          });
        }
      });
    });
    return SafeArea(

      child: Scaffold(

          drawer: Drawer(
            child: ListView(

              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName:Text('$userName') ,
                  accountEmail:Text('$email'),

                  currentAccountPicture: CircleAvatar( radius: 30, child: ClipOval(child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,

                  ),),),
                ),

                ListTile(
                  title: Text('Profile'),
                  leading: Icon(Icons.account_circle),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>ProfileUi()));
                  },
                ),
                ListTile(
                  title: Text('Daily Graph'),
                  leading: Icon(Icons.add_chart),
                  onTap: () {
                    Navigator.of(context).pop();
                    updateChatValues();
                  },
                ),


                ListTile(
                  title: Text('Water details'),
                  leading: Icon(Icons.account_circle),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Graph ()));
                  },
                ),
                // ListTile(
                //   title: Text('Settings'),
                //   leading: Icon(Icons.settings),
                //  onTap: () {
                //    Navigator.of(context).pop();
                //    Navigator.of(context).push(MaterialPageRoute(
                ///       builder: (BuildContext context) => SettingScreen()));
                // },
                //   ),
                ListTile(
                  title: Text('Contact Us'),
                  leading: Icon(Icons.support),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SMS()
                    )
                    );
                  },
                ),
                ListTile(
                  title: Text('Logout From this Device'),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => loginscreen()));
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(title: Text('Home Page'),actions: [
            IconButton(icon: Icon(Icons.print), onPressed: (){

            })
          ],),
          body:Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(height: 280,
                  child: Stack(
                    children: [Container(color:Colors.purple[700],
                      height: 180,child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                        child: Row(children: [Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.white
                          ),image: DecorationImage(fit: BoxFit.fill,image:AssetImage("assets/images/1234973_409665125841417_9047535615645237547_n.jpg"))
                          ),
                        ),
                          Padding(padding: EdgeInsets.symmetric(vertical:50.0,horizontal: 5),child: Column(children: [
                            Padding(padding: EdgeInsets.symmetric(vertical:4,horizontal:0
                            ),child:
                            Text("$userName ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),),
                            //    Text("$userName ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                            //Text("$userName ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
//Column(children: [Padding(padding: EdgeInsets.symmetric(),child: Text(""),),Text("$email ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)],)
                            Padding(padding: EdgeInsets.symmetric(horizontal: 3 ),child:
                            Text("$email ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),),
                          ],

                          )

                            ,)
                        ],

                        ),

                      ),

                    )],
                  ),)

              ],
            ),
          )

      ),
    );
  }
  double totalWaterConsumed=0;
  // ignore: non_constant_identifier_names
  Widget PostsUI(
      String Email,
      String Address,
      ) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(14.0),
      child: Container(
        padding: EdgeInsets.all(14),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(Email, style: Theme.of(context).textTheme.subtitle1),
              Text(Address, style: Theme.of(context).textTheme.subtitle1),
              Text(flatno, style: Theme.of(context).textTheme.subtitle1),
            ]),
      ),
    );
  }

  void updateChatValues() {
    _databaseReference
        .child("usersdata")
        .child("BNUzWwEH8VfnpxAdzeN8p8L0PR23")
        .child("-MZqeb0NYf5kkCWXgDIF")
        .child("Flat Data")
        .child("Mainline").once().then((value){
      totalWaterConsumed = value.value["Total Water Consumed"];
    });
    _databaseReference
        .child("usersdata")
        .child("BNUzWwEH8VfnpxAdzeN8p8L0PR23")
        .child("-MZqeb0NYf5kkCWXgDIF")
        .child("Flat Data")
        .child("Mainline")
        .child("forGraph").child("TotalWaterConsumed").once().then((value){

      _data = [
        DailyUsageModel(usageValue: double.parse(value.value["afterOneHOur"].toString()), hours: "1", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterTwoHOur"].toString()), hours: "2", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterThreeHOur"].toString()), hours: "3", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterFourHOur"].toString()), hours: "4", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterFiveHOur"].toString()), hours: "5", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterSixHOur"].toString()), hours: "6", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterSevenHOur"].toString()), hours: "7", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterEightHOur"].toString()), hours: "8", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterEightHOur"].toString()), hours: "9", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterNineHOur"].toString()), hours: "10", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterTenHOur"].toString()), hours: "11", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterElevenHOur"].toString()), hours: "12", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterTwelveHOur"].toString()), hours: "13", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterThirteenHOur"].toString()), hours: "14", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterFourteenHOur"].toString()), hours: "15", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterFifteenHOur"].toString()), hours: "16", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterSixteenHOur"].toString()), hours: "17", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterSeventeenHOur"].toString()), hours: "18", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterEighteenHOur"].toString()), hours: "19", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterNineteenHOur"].toString()), hours: "20", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterTwentyOneHOur"].toString()), hours: "21", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue:  double.parse(value.value["afterTwentyTwoHOur"].toString()), hours: "22", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterTwentyThreeHOur"].toString()), hours: "23", color: charts.ColorUtil.fromDartColor(Colors.blue)),
        DailyUsageModel(usageValue: double.parse(value.value["afterTwentyFourHOur"].toString()), hours: "24", color: charts.ColorUtil.fromDartColor(Colors.blue)),
      ];
    }).whenComplete((){

      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) =>DailyUsage(
            totalValueConsumed: totalWaterConsumed.toString(),
            data: _data,
          )));
    });
  }
}
