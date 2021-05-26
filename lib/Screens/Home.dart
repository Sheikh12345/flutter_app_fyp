import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class H extends StatefulWidget {
  @override
  _HState createState() => _HState();
}

class _HState extends State<H> {
  @override
  Widget build(BuildContext context) {
double width=MediaQuery.of(context).size.width;
    return Container(
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
              Padding(padding: EdgeInsets.all(50.0),child: Column(children: [Text("Hussain ",style: TextStyle(color: Colors.white,fontSize: 18),)],

              ),)
            ],

            ),
            
          ),

          )],
        ),)

      ],
    ),
    );
  }
}
