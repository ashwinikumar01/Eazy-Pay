import 'dart:convert';
import 'package:eazy_pay/Animation/FadeAnimation.dart';
import 'package:eazy_pay/models/phone_verify.dart';
import 'package:eazy_pay/screens/login_page.dart';
import 'package:eazy_pay/screens/phone_verify/banks_list.dart';
import 'package:eazy_pay/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PhoneVerifyScreen extends StatefulWidget {
  @override
  _PhoneVerifyScreenState createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  final _phoneController = TextEditingController();
  bool isLoading = false;
  bool afterPhoneEnter = false;
  Map userData = {};
  List banks = [];
  FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future getUserData() async {
    userData["phoneNumber"] = _phoneController.text;
    print(userData);
  }

  Future<PhoneVerify> signUp() async {
    try {
      setState(() {
        afterPhoneEnter = false;
        isLoading = true;
      });

      await getUserData();

      final response = await http.post(
        Uri.https(apiUrl, "/api/auth/signup"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(userData),
      );
      print(response.body);
      // String token = JsonDecode(response.body)["token"];

      // await secureStorage.write(key: "token", value: token);
      // print(token);
      if (json.decode(response.body)["success"] == false) {
        setState(() {
          afterPhoneEnter = false;
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 5000),
            content: Text(json.decode(response.body)["error"]),
          ),
        );
      } else {
        setState(() {
          banks = json.decode(response.body)["banks"];
          print(banks[0]["name"]);
          afterPhoneEnter = true;
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 5000),
            content: Text(json.decode(response.body)["message"]),
          ),
        );
      }
      return PhoneVerify.fromJson(json.decode(response.body));
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
        afterPhoneEnter = false;
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
                          "Phone Verify",
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
                            _phoneController.text.length < 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(milliseconds: 5000),
                              content: Text("Please enter valid details"),
                            ),
                          );
                        } else {
                          await signUp();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BanksList(banks: banks),
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
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: 0,
                            width: 0,
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: FlatButton(
                          color: Colors.yellow,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          child: Text("Login"),
                        ),
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
