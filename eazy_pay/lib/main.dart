import 'package:eazy_pay/screens/home_screen.dart';
import 'package:eazy_pay/Screens/login_page.dart';
import 'package:eazy_pay/Screens/validation_screen.dart';
import 'package:flutter/material.dart';
import 'package:eazy_pay/Screens/signup_page.dart';
import 'package:eazy_pay/Screens/profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Signup(),
    );
  }
}
