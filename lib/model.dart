import 'package:cloud_firestore/cloud_firestore.dart';

class UserModels{
  String username;
  String email;
  String mobile;
  String address;
  String password;
  String confirmpassword;
  String flatno;
  String pin;
  String uid;
  Timestamp timestamp;
  UserModels({this.uid,this.pin,this.address,this.mobile,this.email,this.username,this.timestamp,this.flatno,this.confirmpassword,this.password});

  factory UserModels.fromJson(Map map){
    return UserModels(
        username: map['username'],
        email: map['email'],
        mobile: map['mobile'],
        address: map['address'],
        pin: map['pin'],
        flatno: map['Flat no'],
        password: map['password'],
        confirmpassword: map['confirm password'],
        uid: map['uid'],
        timestamp: map['timestamp']
    );
  }
  toMap() {
    return{
      "username": username,
      "email":email,
      "mobile":mobile,
      "address":address,
      "password":password,
      "confirmpassword":confirmpassword,
      "pin": pin,"flatno": flatno,
      "uid":uid,
      "timestamp":FieldValue.serverTimestamp(),
    };


  }
}
