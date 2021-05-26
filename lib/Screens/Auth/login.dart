import 'signUp.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../forget.dart';
import '../../homescreen.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: camel_case_types
class loginscreen extends StatefulWidget {
  @override
  _loginscreenState createState() => _loginscreenState();
}

// ignore: camel_case_types
class _loginscreenState extends State<loginscreen> {

  bool _secureText = true;
  bool isLoading = false;
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading?Center(child: SpinKitFadingCircle(color: Colors.green,),):
        SingleChildScrollView(child:Stack(
          children: [
            Container(
                height: 250.0,
                child:AppBar(
                  automaticallyImplyLeading: false,
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
                                prefix:Icon(FontAwesomeIcons.solidEnvelope,color: Colors.blue,size:30),
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
                                prefix:Icon(FontAwesomeIcons.key,color: Colors.blue,size:30),
                                hintText: 'password',
                                labelText: 'password',

                              ),
                              obscureText: _secureText,
                            ),
                            SizedBox(height: 8.0),
                            InkWell(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text("Forgot Password?",style: TextStyle(color: Colors.blue),),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>ForgetScreen()));
                              },
                            ),
                            SizedBox(height: 8.0),
                            InkWell(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 100.0,vertical: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      color: Colors.blue
                                  ),
                                  child: Text('LogIn',style: TextStyle(color: Colors.white),),
                                ),
                                onTap: (){
                                  login();
                                }
                            ),
                            SizedBox(height: 10.0),
                            Container(alignment: Alignment.center,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account?"),
                                  SizedBox(width:5.0),
                                  InkWell(
                                      child: Text('SignUp',style: TextStyle(color: Colors.blue),),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=>signupscreen()));
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
  void login()async{
    try{
      if(_formKey.currentState.validate()){
        setState(() {
          isLoading= true;
        });
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text).then((user){
          setState(() {
            isLoading= false;
          });
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()), (route) => false);
          Fluttertoast.showToast(
              msg: "Welcome Back $emailController.text",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
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
          msg: "Credentials are not match.Try Again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }
}


