import 'dart:math';

import 'package:nearby_connections/nearby_connections.dart';

Future<dynamic> startAdvertising() async {
  final String userName = Random().nextInt(10000).toString();
  final Strategy strategy = Strategy.P2P_POINT_TO_POINT;
  try {
    bool a = await Nearby().startAdvertising(
      userName,
      strategy,
      onConnectionInitiated: (String id, ConnectionInfo info) {
        // Called whenever a discoverer requests connection
      },
      onConnectionResult: (String id, Status status) {
        // Called when connection is accepted/rejected
      },
      onDisconnected: (String id) {
        // Callled whenever a discoverer disconnects from advertiser
      },
      serviceId: "com.yourdomain.appname", // uniquely identifies your app
    );
  } catch (exception) {
    // platform exceptions like unable to start bluetooth or insufficient permissions
  }
}
