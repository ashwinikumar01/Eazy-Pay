import 'dart:convert';
import 'package:eazy_pay/Animation/FadeAnimation.dart';
import 'package:eazy_pay/models/phone_verify.dart';
import 'package:eazy_pay/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhoneVerifyScreen extends StatefulWidget {
  @override
  _PhoneVerifyScreenState createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  final _phoneController = TextEditingController();
  bool isLoading = false;
  Map userData = {};

  Future getUserData() async {
    userData["phoneNumber"] = _phoneController.text;
    print(userData);
  }

  Future<PhoneVerifyScreen> signUp() async {
    try {
      await getUserData();
      setState(() {
        isLoading = true;
      });

      final response = await http.post(
        Uri.https(apiUrl, "api/auth/signup"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(userData),
      );
      print(response.body);
      if (json.decode(response.body)["success"] == false) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 5000),
            content: Text(json.decode(response.body)["error"]),
          ),
        );
      } else {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 5000),
            content: Text(json.decode(response.body)["message"]),
          ),
        );
      }
      PhoneVerify.fromJson(json.decode(response.body));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 5000),
          content: Text(
            error,
          ),
        ),
      );
      setState(() {
        isLoading = false;
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
                          "Sign Up",
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
                                  keyboardType: TextInputType.number,
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
                    FadeAnimation(
                        1.7,
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                    SizedBox(height: 40.0),
                    Center(
                      child: Text(
                        "Already have an account?",
                        style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, .6),
                            fontSize: 15.0),
                      ),
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
