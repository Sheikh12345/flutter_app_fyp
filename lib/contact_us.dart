import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import 'homescreen.dart';
class SMS extends StatefulWidget {
 SMS({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SMSState createState() => _SMSState();
}
class _SMSState extends State<SMS> {
  TwilioFlutter twilioFlutter;
  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
        accountSid: 'AC86d1d6074ee566dea92bd7b9f6ba7aaa',
        authToken: '32265bf9ca1fb058aab1f77c1d4f3552',
        twilioNumber: '+16514139542');
    super.initState();
  }
  void sendSms() async {
    twilioFlutter.sendSMS(
        toNumber: '+923212444600', messageBody: smsController.text);
  }
  void sendwh()async{

    twilioFlutter.sendWhatsApp(toNumber : '+923212444600',
        messageBody : smsController.text);
  }
  //void getSms() async {
  //  var data = await twilioFlutter.getSmsList();
  // print(data);
  //  await twilioFlutter.getSMS('***************************');
  //}
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  TextEditingController smsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Contact Us"),),
      body:
        SingleChildScrollView(child: Stack(
children: [

   Padding(padding: EdgeInsets.symmetric(vertical: 30.0,horizontal: 20.0),
  child: Card(
  child: Form( key: _formKey,child: Padding(
                        padding: EdgeInsets.symmetric(vertical:45,
                            horizontal: 20.0),
                        child: Column(
                          children: [
                            SizedBox(height: 15.0),
                            TextFormField(
                              controller: smsController,
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'Message can not be empty';
                                }
                                else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                                border: OutlineInputBorder(),
                                hintText: 'Please Enter Full Name \n & Your issue ',
                                hintStyle: TextStyle(color: Colors.black,fontSize: 18) ,
                                labelText: 'Message',
                                labelStyle: TextStyle(color: Colors.black,fontSize: 18),
                                prefix: Icon(FontAwesomeIcons.solidEnvelope,color: Colors.blueAccent,size:20),
                              ),
                              keyboardType: TextInputType.multiline,
                                maxLines: null
                            ),

                      ],
                     ),
                        
                        
                        ),
  ),
)


,)
]
        ),

        ),
   floatingActionButton: FloatingActionButton(
     onPressed:(){  sendSms() ;
       ScaffoldMessenger.of(context).showSnackBar(SnackBar
         (content:Text("SMS Sent Succesfully")),);
      Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Home() ),);
     },


    tooltip: 'Send Sms',
  child: Icon(Icons.send),
    ),
    );
  }
}
class MrSnackpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Snack Page",
    style: Theme.of(context).textTheme.headline2,
    ),
    ),
    );
  }
}
