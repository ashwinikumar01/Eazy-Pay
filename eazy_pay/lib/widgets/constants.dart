import 'package:flutter/material.dart';

const apiUrl = "https://eazy-pay-api.herokuapp.com";

AppBar titleAppbar(context,
    {@required String title,
    List<Widget> actions,
    bool automaticallyImplyLeading = true,
    Widget leading}) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    automaticallyImplyLeading: automaticallyImplyLeading,
    actions: actions != null ? actions : null,
    title: Text(
      "$title",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
