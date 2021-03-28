import 'package:eazy_pay/screens/phone_verify/phone-verify_screen.dart';
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
  String token;
  FlutterSecureStorage secureStorage = FlutterSecureStorage();

  void getToken() async {
    token = await secureStorage.read(key: "token");
    print(token);
  }

  Widget homePage() {
    if (token == null) {
      return PhoneVerifyScreen();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eazy Pay',
      home: homePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    );
  }
}
