import 'package:eazy_pay/Animation/FadeAnimation.dart';
import 'package:eazy_pay/Screens/signup_page.dart';
import 'package:eazy_pay/Screens/validation_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
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
                  height: 300,
                  child: Stack(
                    children: [
                      Positioned(
                          child: FadeAnimation(
                              1,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background.PNG'),
                                  fit: BoxFit.fill,
                                )),
                              ))),
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
                            "LOGIN",
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
                                              color: Colors.grey[200]))),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Phone Number",
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
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
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ValidationScreen()));
                              },
                              child: Center(
                                child: Text(
                                  "Get OTP",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 40.0),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        },
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, .6),
                                fontSize: 15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
