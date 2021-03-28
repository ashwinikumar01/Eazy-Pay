import 'dart:convert';
import 'package:eazy_pay/Animation/FadeAnimation.dart';
import 'package:eazy_pay/models/signup_email.dart';
import 'package:eazy_pay/screens/home_screen.dart';
import 'package:eazy_pay/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpScreen extends StatefulWidget {
  final String id;

  const SignUpScreen({Key key, @required this.id}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  Map userData = {};

  FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future getData(String id) async {
    userData["id"] = id;
    userData["email"] = _emailController.text;
    print(userData);
  }

  Future<SignupEmail> signUpEmail(String id) async {
    try {
      await getData(id);
      setState(() {
        _isLoading = true;
      });
      var response = await http.post(
        Uri.https(apiUrl, "/api/auth/signup/complete"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: json.encode(userData),
      );

      print(response.body);
      if (json.decode(response.body)["success"] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 5000),
            content: Text(json.decode(response.body)["error"]),
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });

      String token = json.decode(response.body)["token"];
      print(token);
      await secureStorage.write(key: "token", value: token);

      if (json.decode(response.body)["success"] == true) {
        print(token);
      }
      return SignupEmail.fromJson(json.decode(response.body));
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
                          "Email Signup",
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
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Your Email",
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
                        if (_emailController.text == "" ||
                            _emailController.text.isEmpty ||
                            !_emailController.text.contains("@")) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(milliseconds: 5000),
                              content: Text("Please enter a valid email id"),
                            ),
                          );
                        } else {
                          await signUpEmail(widget.id);
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
                            "Submit",
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
