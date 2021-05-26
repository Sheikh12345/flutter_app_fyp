import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}
class _MyHomeScreenState extends State<MyHomeScreen> {
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
        toNumber: '+923212444600', messageBody: 'oye kanjar');
  }
  //void getSms() async {
 //  var data = await twilioFlutter.getSmsList();
 // print(data);
  //  await twilioFlutter.getSMS('***************************');
  //}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      //title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Press the button to send SMS.',
          style: TextStyle(
              color: Colors.black,
              fontSize: 16
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendSms,
        tooltip: 'Send Sms',
        child: Icon(Icons.send),
      ),
    );
  }
}