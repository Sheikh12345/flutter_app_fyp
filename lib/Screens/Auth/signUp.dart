
//import 'package:auth_ind/loginui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model.dart';

import '../../homescreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login.dart';

// ignore: camel_case_types
class signupscreen extends StatefulWidget {
  @override
  _signupscreenState createState() => _signupscreenState();
}

// ignore: camel_case_types
class _signupscreenState extends State<signupscreen> {
  currentUser() {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid.toString();
    return uid;
  }
  bool _secureText = true;
  bool isLoading = false;

  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController flatnoController = TextEditingController();
  @override
  bool value=false;
  final ref =FirebaseDatabase.instance.reference();
  onUpdate(){
    setState(() {
      value=!value;
    });
  }
  Widget build(BuildContext context) {

    return Scaffold(
        body: isLoading?
        Center(child: SpinKitFadingCircle(color: Colors.green,),):
        SingleChildScrollView(child:Stack(
          children: [
            Container(
                height: 250.0,
                child:AppBar(
                  elevation: 0.0,
                )
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 100.0,horizontal: 20.0),
              child: Card(
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            SizedBox(height: 15.0),
                            // UserimagePicker(),
                            //SizedBox(height:20),
                            TextFormField(
                              controller: usernameController,
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'UserName can not be empty';
                                }
                                else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'username',
                                labelText: 'UserName',
                                prefix: Icon(FontAwesomeIcons.solidEnvelope,color: Colors.blueAccent,size:20),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                              controller: phoneController,
                              validator: (String value){
                                if(value.isEmpty){
                                  return "PhoneNumber can not be empty";
                                }//if(value.length>11 )
                                //{
                                //return "Enter valid phone number";
                                // }
                                else{
                                  return null;
                                }
                              },

                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'phonenumber',
                                labelText: 'PhoneNumber',
                                prefix: Icon(FontAwesomeIcons.mobile,color: Colors.blueAccent,size:20),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 8.0),
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
                                hintText: 'email',
                                labelText: 'Email',
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                              controller: passwordController,
                              validator: (String value){
                                if(value.isEmpty){
                                  return "Password can not be empty";
                                }if(value.length<7){
                                  return "Password should be grater than 6 char";
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(icon: Icon(
                                    _secureText ? Icons.visibility_off : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _secureText = !_secureText;
                                    });
                                  },),
                                border: OutlineInputBorder(),
                                hintText: 'password',
                                labelText: 'password',
                                prefix: Icon(FontAwesomeIcons.key,color: Colors.blueAccent,size:20),
                              ),
                              obscureText: _secureText,
                            ),


                            SizedBox(height: 8.0),
                            TextFormField(
                              controller: confirmpasswordController,
                              validator: (String value){
                                if(value.isEmpty||value!=passwordController.text){
                                  return "Password not match";
                                }if(value.length<7){
                                  return "Password should be grater than 6 char";
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(icon: Icon(
                                    _secureText ? Icons.visibility_off : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _secureText = !_secureText;
                                    });
                                  },),
                                border: OutlineInputBorder(),
                                hintText: 'Confirm password',
                                labelText: 'Confirm password',
                                prefix: Icon(FontAwesomeIcons.key,color: Colors.blueAccent,size:20),
                              ),
                              obscureText: _secureText,
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                              controller: addressController,
                              validator: (String value){
                                if(value.isEmpty){
                                  return "Address can not be empty";
                                }if(value.length<7){
                                  return "Enter Correct Address";
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Address',
                                labelText: 'Address',
                                prefix: Icon(FontAwesomeIcons.home,color: Colors.blueAccent,size:20),     ),
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                              controller: flatnoController,
                              validator: (String value){
                                if(value.isEmpty){
                                  return "Flat No can not be empty";
                                }if(value.length<2){
                                  return "Enter Correct Flat No";
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Flat No',
                                labelText: 'Flat No',
                              ),
                            ),
                            SizedBox(height: 8.0),
                            // TextFormField(
                            //   keyboardType: TextInputType.emailAddress,
                            //   controller: pincodeController,
                            //   validator: (String value){
                            //     if(value.isEmpty){
                            //       return "Pin can not be empty";
                            //     }if(value.isEmpty ||value.length>4 || value.length<4){
                            //       return "Code should be 4 digits ";}
                            //     if(value.isEmpty || value!="ABCD"){
                            //       return "Wrong Code  ";
                            //     }else{
                            //       return null;
                            //     }
                            //   },
                            //   decoration: InputDecoration(
                            //     border: OutlineInputBorder(),
                            //     hintText: 'Code',
                            //     labelText: 'Code Provided by Company',
                            //     prefix: Icon(FontAwesomeIcons.code,color: Colors.blueAccent,size:20),      ),
                            // ),
                            SizedBox(height: 8.0),
                            InkWell(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 100.0,vertical: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      color: Colors.blue
                                  ),
                                  child: Text('SignUp',style: TextStyle(color: Colors.white),),
                                ),
                                onTap: (){
                                  Register();
                                  //  realtimedb();
                                }
                            ),
                            SizedBox(height: 10.0),
                            Container(alignment: Alignment.center,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Already have an account?'),
                                  SizedBox(width:5.0),
                                  InkWell(
                                      child: Text('LogIn',style: TextStyle(color: Colors.blue),),
                                      onTap: (){
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=>loginscreen()));
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
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
  // ignore: non_constant_identifier_names
  void Register()async{
    try{
      if(_formKey.currentState.validate()){
        setState(() {
          isLoading= true;
        });
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text).then((user){
          setState(() {
            isLoading= false;
          });
          Post();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()), (route) => false);
          Fluttertoast.showToast(
              msg: "SignUp Successfully ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
        });
      }
    }
    on FirebaseAuthException catch(e){
      setState(() {
        isLoading= false;
      });
      print(e.toString());
      Fluttertoast.showToast(
          msg: "Email is Already taken ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }

  void realtimedb(){
    setState(() {
      isLoading= true;
    });



  }

  // ignore: non_constant_identifier_names
  void Post() async{
    setState(() {
      isLoading= true;
    });
    // ignore: await_only_futures
    FirebaseAuth firebaseAuth = await FirebaseAuth.instance;
    String uid = firebaseAuth.currentUser.uid.toString();
    UserModels userModels = new UserModels();
    userModels.email = emailController.text;
    userModels.username = usernameController.text;
    userModels.mobile = phoneController.text;
    userModels.address = addressController.text;
    userModels.pin = pincodeController.text;
    userModels.password = passwordController.text;
    userModels.confirmpassword = confirmpasswordController.text;
    userModels.flatno = flatnoController.text;
    userModels.uid = uid;
    DatabaseReference postref = FirebaseDatabase.instance.reference().child('usersdata').child(currentUser());
    postref.push().set({"Name": userModels.username,"Email": userModels.email,"Mobile No":userModels.mobile ,"Address":userModels.address,"flat no":userModels.flatno});

    ref.child("LightState").set({"switch" : !value});

    await FirebaseFirestore.instance.collection('Data').doc(uid).set(userModels.toMap()).then((value){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()), (route) => false);
      Fluttertoast.showToast(
          msg: "SignUp Successfully ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

    });

    setState(() {
      isLoading = false;
    });

  }

}
