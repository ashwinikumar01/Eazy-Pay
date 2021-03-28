import 'package:eazy_pay/Screens/send_screen.dart';
import 'package:flutter/material.dart';
import 'package:nearby_connections/nearby_connections.dart';

class NearbyDevices extends StatefulWidget {
  @override
  _NearbyDevicesState createState() => _NearbyDevicesState();
}

class _NearbyDevicesState extends State<NearbyDevices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nearby Devices"),
          backgroundColor: Colors.purple[800],
          actions: [
            FlatButton.icon(
                onPressed: () {
                  Nearby().stopDiscovery();
                },
                label: Text(
                  "Stop",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                icon: Icon(
                  Icons.stop,
                  color: Colors.white,
                ))
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Send()));
                },
                leading: Icon(Icons.person),
                title: Text("Device $index"),
              );
            }));
  }
}
