import 'package:eazy_pay/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class ValidationScreen extends StatefulWidget {
  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
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
                                image:
                                    AssetImage('assets/images/background.PNG'),
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
                  children: [
                    Row(
                      children: [
                        FadeAnimation(
                            1.3,
                            Text(
                              "Enter OTP",
                              style: TextStyle(
                                  color: Color.fromRGBO(49, 39, 79, 1),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    SizedBox(height: 40.0),
                    FadeAnimation(
                        1.5,
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PinEntryTextField(
                              showFieldAsBox: true,
                              onSubmit: (String pin) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Pin"),
                                        content: Text('Pin entered is $pin'),
                                      );
                                    }); //end showDialog()
                              }, // end onSubmit
                            ), // end PinEntryTextField()
                          ), // end Padding()
                        )),
                    SizedBox(height: 60),
                    FadeAnimation(
                        1.7,
                        Text(
                          "Resend OTP",
                          style: TextStyle(
                              color: Color.fromRGBO(49, 39, 79, .6),
                              fontSize: 15.0),
                        )),
                    SizedBox(height: 40),
                    FadeAnimation(
                        1.9,
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                          child: Center(
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
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
