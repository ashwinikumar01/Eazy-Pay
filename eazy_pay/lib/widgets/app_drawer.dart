import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text(
                'Eazy Pay',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              title: Text('New Screen'),
              onTap: () {},
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
