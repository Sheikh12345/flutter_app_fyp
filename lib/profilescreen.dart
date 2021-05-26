import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
class ProfileUi extends StatefulWidget {
  @override
  _ProfileUiState createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  @override
  String name,address,flatno ,mobileNumber, email;

  currentUser() {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid.toString();
    return uid;
  }

  void getUserData() async {

    await FirebaseFirestore.instance
        .collection('Data') // suppose you have a collection named "Users"
        .doc( currentUser())
        .get()
        .then((value) {
      setState(() {
        name = value["username"];
        mobileNumber = value["mobile"];
        email = value["email"];
        flatno=value["flatno"];
        address=value["address"];
      });
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,appBar: AppBar(//backgroundColor: Colors.blue,

      title: Text("Profile",style: TextStyle(fontSize: 25,color: Colors.black
      ),
      )
      ,
      centerTitle: true,elevation: 0,
    ),
      body: Stack(children: [
        Container(height: double.infinity,width: double.infinity,color: Color(0xfff6f6f6),
          padding: EdgeInsets.only(top: 250,left: 20,right: 20),
          child:  _text() ,)
        ,Container(height: 180,color: Colors.white,),
        Container(margin: EdgeInsets.symmetric(vertical:40,horizontal:20),width: double.infinity,height: 190,
          decoration: BoxDecoration(color:Color(0xfff6f6f6),borderRadius: BorderRadius.circular(10)
              ,boxShadow: [BoxShadow(color:Color.fromARGB(90,20,20,20),blurRadius: 0.8,offset: Offset(9,9))]

          ),

          child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [CircleAvatar( radius: 40,
            child: CircleAvatar(backgroundColor: Colors.grey,radius: 37 , child: Icon(Icons.person),),


          ),
            SizedBox(height: 2,),
            Text('$name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
            SizedBox(height: 2,),
            Text('$email',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey[800]),),


          ],),





        )


      ],),
    );
  }
  Widget _text(){
    return   Container(child: Center(


      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        children: <Widget>[
          //CircleAvatar(child:ba ,),

          Card(elevation: 4,shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
            child: ListTile(

              title: Text('Mobile Number',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
              subtitle: Text('$mobileNumber',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey[800])),
            ),


          )
          ,Card(elevation: 4,shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
            child: ListTile(

              title: Text('Flat Number',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
              subtitle: Text('$flatno',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey[800])),
            ),


          )        ,
          Card(elevation: 4,shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
            child: ListTile(

              title: Text('Address',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
              subtitle: Text('$address',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey[800])),
            ),


          )         ,


        ],
      ),
    ),);


  }
}