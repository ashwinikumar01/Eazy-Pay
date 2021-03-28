import 'package:eazy_pay/models/send_money_online.dart';
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
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  bool dataPresent = false;

  Future sendMoney() async {
    data["money"] = _moneyController.text;
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
          "x-auth-token": token,
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
      backgroundColor: Colors.purple[800],
      body: ListView(
        children: [
          Row(
            children: [
              FloatingActionButton(
                backgroundColor: Colors.purple[800],
                elevation: 0.0,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 70.0),
              Container(
                padding: EdgeInsets.fromLTRB(120.0, 0, 120.0, 0),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40.0,
                      backgroundImage: AssetImage("assets/images/username.jpg"),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Paying",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "PHONE NUMBER",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white),
                        ),
                      ),
                      child: TextField(
                        controller: _moneyController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Amount",
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 30.0),
                    child: FloatingActionButton(
                      backgroundColor: Color.fromRGBO(49, 39, 79, 1),
                      onPressed: () {},
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
