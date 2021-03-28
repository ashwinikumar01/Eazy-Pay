import 'package:flutter/material.dart';

class Send extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        elevation: 0.0,
      ),
      backgroundColor: Colors.purple[800],
      body: ListView(
        children: [
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
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                      child: TextField(
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
