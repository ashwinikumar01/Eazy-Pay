import 'package:flutter/material.dart';

class RequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.purple[800],
      ),
      backgroundColor: Colors.purple[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Connected with",
              style: TextStyle(color: Colors.white, fontSize: 35.0),
            ),
            SizedBox(height: 20.0),
            Text(
              "PHONE NUMBER",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            SizedBox(height: 150.0),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromRGBO(49, 39, 79, 1),
              ),
              child: FlatButton(
                onPressed: () {},
                child: Center(
                  child: Text(
                    "Disconnect",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
