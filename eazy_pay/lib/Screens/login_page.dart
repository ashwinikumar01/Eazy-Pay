import 'dart:convert';

import 'package:eazy_pay/Animation/FadeAnimation.dart';
import 'package:eazy_pay/widgets/constants.dart';
import 'package:http/http.dart' as http;
import 'package:eazy_pay/models/login_model.dart';
import 'package:eazy_pay/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  Map userData = {};

  Future getPhone() async {
    userData["phoneNumber"] = _phoneController.text;
    print(userData);
  }

  Future<LoginModel> login() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await getPhone();

      final response = await http.post(
        Uri.https(apiUrl, "/api/auth/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(userData),
      );
      print(response.body);
      if (json.decode(response.body)["success"] == false) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 5000),
            content: Text(json.decode(response.body)["error"]),
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 5000),
            content: Text(json.decode(response.body)["message"]),
          ),
        );
      }
      return LoginModel.fromJson(json.decode(response.body));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 5000),
          content: Text(
            error.toString(),
          ),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/images/background.PNG'),
                            fit: BoxFit.fill,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeAnimation(
                        1.3,
                        Text(
                          "Login",
                          style: TextStyle(
                              color: Color.fromRGBO(49, 39, 79, 1),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(height: 40.0),
                    FadeAnimation(
                        1.5,
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(196, 135, 198, 0.3),
                                  blurRadius: 20,
                                ),
                              ]),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                ),
                                child: TextField(
                                  controller: _phoneController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Your Phone No",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(height: 40),
                    GestureDetector(
                      onTap: () async {
                        if (_phoneController.text == "" ||
                            _phoneController.text.isEmpty ||
                            _phoneController.text.length < 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(milliseconds: 5000),
                              content: Text("Please enter a valid phone no"),
                            ),
                          );
                        } else {
                          await login();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromRGBO(49, 39, 79, 1),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: 0,
                            width: 0,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
