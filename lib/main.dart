import 'package:flutter/material.dart';
import 'package:login_flow/presentation/home_page/home/homepage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


void main() async {
  runApp(const App());
}


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
