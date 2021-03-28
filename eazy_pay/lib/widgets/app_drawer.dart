import 'package:eazy_pay/Screens/profile_page.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:
          /*SingleChildScrollView(
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
              title: Text('Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            Divider(),
          ],
        ),
      ),*/
          ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 250.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/background.PNG"),
                fit: BoxFit.fill,
              )),
            ),
          ),
          SizedBox(height: 20.0),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            title: Text("Profile",
                style: TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 1.5,
                )),
            leading: Icon(Icons.person, color: Colors.black, size: 30.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            title: Text("Log Out",
                style: TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 1.5,
                )),
            leading: Icon(Icons.exit_to_app, color: Colors.black, size: 30.0),
          ),
        ],
      ),
    );
  }
}
