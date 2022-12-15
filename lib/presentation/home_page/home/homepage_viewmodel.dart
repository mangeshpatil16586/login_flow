import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:login_flow/model/model.dart';
import 'package:login_flow/repositry/repositry_imp.dart';
import 'package:uuid/uuid.dart';

class HomePageViewModel implements HomePageInput,HomePageOutPut{
  StreamController<String> _nameStreamController=StreamController<String>.broadcast();
  StreamController<String> _emailStramController=StreamController<String>.broadcast();
  StreamController<String> _passwodStramController=StreamController<String>.broadcast();
  StreamController<String> _addressStramController=StreamController<String>.broadcast();
  StreamController<String> _phonenoStramController=StreamController<String>.broadcast();
  StreamController<bool> _allStreamController=StreamController<bool>.broadcast();
  bool nameIsNotEmpty=false;
  bool emailIsNotEmpty=false;
  bool passwordIsNotEmpty=false;
  bool addressIsNotEmpty=false;
  bool phonenoIsNotEmpty=false;

  User user=User(name: '', email: '', password: '', address: '', phoneNo: '');

  var rep=Repository();
  @override
  Sink get userName => _nameStreamController.sink;

  @override
  Sink get inputAddress => _addressStramController.sink;


  @override
  Sink get inputEmail => _emailStramController.sink;


  @override
  Sink get inputPassword => _passwodStramController.sink;


  @override
  Sink get inputPhoneNo => _phonenoStramController.sink;

  @override
  Sink get allInputs => _allStreamController.sink;


  @override
  Stream<String> get name => _nameStreamController.stream.map((name) {
    if(name.isNotEmpty){
      nameIsNotEmpty=true;
      user.name=name;
    }
    return name;
  });

  @override
  Stream<String> get outputAddress => _addressStramController.stream.map((adress){
    if(adress.isNotEmpty){
      addressIsNotEmpty=true;
      user.address=adress;
    }
    return adress;
  });

  @override
  Stream<String> get outputEmail => _emailStramController.stream.map((email){
    if(email.isNotEmpty){
      emailIsNotEmpty=true;
      user.email=email;
    }
    return email;
  });

  @override
  Stream<String> get outputPassword => _passwodStramController.stream.map((password){
    if(password.isNotEmpty){
      passwordIsNotEmpty=true;
      user.password=password;
    }
    return password;
  });

  @override
  Stream<String> get outputPhoneNo => _phonenoStramController.stream.map((phoneno) {
    if(phoneno.isNotEmpty){
      phonenoIsNotEmpty=true;
      user.phoneNo=phoneno;
    }
    return phoneno;
  });

  Future<bool> insertUsers()async{
    if(await rep.checkEmail(user.email)){
      return false;
    }
    if(nameIsNotEmpty && emailIsNotEmpty && passwordIsNotEmpty && addressIsNotEmpty && phonenoIsNotEmpty){
     return await rep.insertUser(user);
    }else{
      throw Exception('Not able to add');
    }
  }


  @override
  Stream<bool> get checkAllOutput => _allStreamController.stream.map((allOutputValid){
    return isAllInputValid();
  });

   bool isAllInputValid(){
     if(nameIsNotEmpty && emailIsNotEmpty && passwordIsNotEmpty && addressIsNotEmpty && phonenoIsNotEmpty){
       return true;
     }else{
       return false;
     }
   }

}

abstract class HomePageInput{
  Sink get userName;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputAddress;
  Sink get inputPhoneNo;
  Sink get allInputs;

}

abstract class HomePageOutPut{
  Stream<String> get name;
  Stream<String> get outputEmail;
  Stream<String> get outputPassword;
  Stream<String> get outputAddress;
  Stream<String> get outputPhoneNo;
  Stream<bool> get checkAllOutput;

}