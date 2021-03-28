import 'package:flutter/material.dart';

class Topup extends StatefulWidget {
  @override
  _TopupState createState() => _TopupState();
}

class _TopupState extends State<Topup> {
  double balance = 0.0;
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
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Your Wallet",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Available Balance  ₹ $balance",
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
          SizedBox(height: 80.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Add Money",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white))),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "   ₹ Amount",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 100.0),
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
                  "Proceed",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
