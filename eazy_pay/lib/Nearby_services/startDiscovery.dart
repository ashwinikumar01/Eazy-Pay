import 'dart:math';

import 'package:nearby_connections/nearby_connections.dart';

Future<dynamic> startDiscovery() async {
  final String userName = Random().nextInt(10000).toString();
  final Strategy strategy = Strategy.P2P_POINT_TO_POINT;
  try {
    bool a = await Nearby().startDiscovery(
      userName,
      strategy,

      onEndpointFound: (String id, String userName, String serviceId) {
        // called when an advertiser is found
      },
      onEndpointLost: (String id) {
        //called when an advertiser is lost (only if we weren't connected to it )
      },
      serviceId: "com.yourdomain.appname", // uniquely identifies your app
    );
  } catch (e) {
    // platform exceptions like unable to start bluetooth or insufficient permissions
  }
}
