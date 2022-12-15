import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/model.dart';

class Repository{

  Future<Database> intiDB() async{
    return   openDatabase(
      join(await getDatabasesPath(),'user.db'),
      onCreate: (db,version){
        return db.execute('CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT,password TEXT,address TEXT,phoneno TEXT)');
      },
      version: 1,
    );
  }
  Future<bool> insertUser(User user) async{
    bool userAddedSucessfully=false;
    final db=await intiDB();
    await db.insert('users', user.toMap(),conflictAlgorithm: ConflictAlgorithm.replace).whenComplete((){
      userAddedSucessfully=true;
    });
    return userAddedSucessfully;

  }

  Future<bool> login(String email,String password) async{
    final db=await intiDB();
    var user=await db.rawQuery("SELECT * FROM users WHERE email LIKE '%$email%' AND password LIKE '%$password%'");
    if(user.isNotEmpty){
      print(user.toString());
      return true;
    }else{
      throw Exception('User Not Found');
    }

  }

  Future<bool> checkEmail(String email) async{
    final db=await intiDB();
    var user=await db.rawQuery("SELECT * FROM users WHERE email LIKE '%$email%'");
    if(user.isNotEmpty){
      return true;
    }else{
      return false;
    }

  }
}