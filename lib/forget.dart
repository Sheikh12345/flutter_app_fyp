import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'backgrounimage.dart';
import 'Screens/Auth/login.dart';

class ForgetScreen extends StatefulWidget {
  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

// ignore: camel_case_types
class _ForgetScreenState extends State<ForgetScreen> {
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(child:Stack(
          children: [//Bk(),
            Container(
                height: 250.0,
                child:AppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0.0,
                )
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 300.0,horizontal: 20.0),
              child: Card(
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            SizedBox(height: 15.0),
                            TextFormField(
                              controller: emailController,
                              validator: (String value){
                                if(value.isEmpty){
                                  return "Email Can not be empty";
                                }if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]").hasMatch(value)) {
                                  return "please enter a valid email";
                                }
                                else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Your Registered Email Id',
                                labelText: 'Email',
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 15.0),
                            InkWell(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                color: Colors.blue[900],
                                alignment: Alignment.center,
                                child: Text("Get ResetPassword Link",style: TextStyle(color: Colors.blue[900]),),
                              ),
                              onTap: (){
                                restPass();
                              },
                            ),
                            SizedBox(height: 20.0),
                          ],
                        ),
                      )
                  )
              ),
            )
          ],
        ))
    );
  }

  void restPass() async{
    if(_formKey.currentState.validate()){
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value){
        Navigator.push(context, MaterialPageRoute(builder: (_)=> loginscreen()));
        Fluttertoast.showToast(
            msg: "Link Sent Successfully ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
  }
}



