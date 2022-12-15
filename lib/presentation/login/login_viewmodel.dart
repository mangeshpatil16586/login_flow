import 'dart:async';

import 'package:login_flow/repositry/repositry_imp.dart';

class LoginViewModel implements LoginInput,LoginOutput{
  StreamController<String> _emailStreamController=StreamController<String>.broadcast();
  StreamController<String> _passwordStreamController=StreamController<String>.broadcast();
  String email='';
  String password='';

  @override
  Sink get emailInput => _emailStreamController.sink;


  @override
  Sink get passwordInput => _passwordStreamController.sink;

  @override
  Stream<String> get emailOutput => _emailStreamController.stream.map((userEmail){

    email=userEmail;
    print(email);
    return email;
  });

  @override
  Stream<String> get passwordOutput => _passwordStreamController.stream.map((userPassword){
    password=userPassword;
    print(password);
    return password;
  });

  Future<bool> loginSuccesful(){
    if(email.isNotEmpty && password.isNotEmpty){
      return Repository().login(email, password);
    }else{
      throw Exception('Somthing bad happen');
    }
  }



}

abstract class LoginInput{
  Sink get emailInput;
  Sink get passwordInput;

}

abstract class LoginOutput{
  Stream<String> get emailOutput;
  Stream<String> get passwordOutput;
}