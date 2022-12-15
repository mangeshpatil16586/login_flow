import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Info'),),
      body: Center(
        child: Container(
          child: Text('Hello'),
        ),
      ),
    );
  }
}
