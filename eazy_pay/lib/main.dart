import 'package:eazy_pay/screens/phone_verify/phone-verify_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eazy Pay',
      home: PhoneVerifyScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
