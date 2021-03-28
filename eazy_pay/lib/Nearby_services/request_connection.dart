import 'dart:math';

import 'package:nearby_connections/nearby_connections.dart';

Future<void> requestConnection() {
  final String userName = Random().nextInt(10000).toString();
  final String id = Random().nextInt(10000).toString();
  final Strategy strategy = Strategy.P2P_POINT_TO_POINT;
  try {
    Nearby().requestConnection(
      userName,
      id,
      onConnectionInitiated: (id, info) {},
      onConnectionResult: (id, status) {},
      onDisconnected: (id) {},
    );
  } catch (exception) {
    // called if request was invalid
  }
}
