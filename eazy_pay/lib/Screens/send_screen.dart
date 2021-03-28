import 'package:eazy_pay/models/send_money_online.dart';
import 'package:eazy_pay/screens/home_screen.dart';
import 'package:eazy_pay/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Send extends StatefulWidget {
  @override
  _SendState createState() => _SendState();
}

class _SendState extends State<Send> {
  bool _isLoading = false;
  Map data = {};
  final _moneyController = TextEditingController();
  final _phoneController = TextEditingController();
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  bool dataPresent = false;

  Future sendMoney() async {
    data["phoneNumber"] = _phoneController.text;
    data["amount"] = _moneyController.text;
    print(data);
  }

  Future<SendMoneyOnline> sendMoneyOnline() async {
    String token = await secureStorage.read(key: "token");
    try {
      await sendMoney();
      setState(() {
        _isLoading = true;
      });
      var response = await http.post(
        Uri.https(apiUrl, "/api/transaction/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(data),
      );
      print(response.body);

      if (json.decode(response.body)["success"] == false) {
        setState(() {
          _isLoading = false;
          dataPresent = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            json.decode(response.body)["error"],
          ),
        ));
      } else {
        setState(() {
          _isLoading = false;
          dataPresent = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            json.decode(response.body)["success"],
          ),
        ));
      }
      return SendMoneyOnline.fromJson(json.decode(response.body));
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: titleAppbar(context, title: "Send Money"),
        body: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _moneyController,
                keyboardType: TextInputType.text,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  fillColor: Colors.blue,
                  labelText: "Enter amount",
                  prefixIcon: Icon(Icons.add),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Please enter amount",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.text,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  fillColor: Colors.blue,
                  labelText: "Enter phone no",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Please enter phone no",
                ),
              ),
            ),
            FlatButton(
              color: Colors.yellow,
              onPressed: () async {
                await sendMoneyOnline();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              child: Text("Send Money"),
            )
          ],
        ));
  }
}
