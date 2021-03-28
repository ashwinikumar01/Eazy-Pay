import 'package:eazy_pay/screens/home_screen.dart';
import 'package:eazy_pay/screens/loading.dart';
import 'package:eazy_pay/screens/phone_verify/phone-verify_screen.dart';
import 'package:eazy_pay/screens/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> _isLoggedIn() async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    if (await storage.read(key: 'token') != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            return MaterialApp(home: HomeScreen());
          } else {
            return MaterialApp(home: PhoneVerifyScreen());
          }
        } else {
          return MaterialApp(home: Center(child: Loading()));
        }
      },
    );
  }
}
