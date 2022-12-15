import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User{
  User({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNo
 });
  String name;
  String email;
  String password;
  String address;
  String phoneNo;

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'password':password,
      'address':address,
      'phoneNo':phoneNo
    };
  }



}