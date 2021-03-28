import 'dart:math';

import 'package:nearby_connections/nearby_connections.dart';

Future<void> acceptConnection() {
  final String id = Random().nextInt(10000).toString();
  Nearby().acceptConnection(id, onPayLoadRecieved: (endpointId, payload) {
    // called whenever a payload is recieved.
  }, onPayloadTransferUpdate: (endpointId, payloadTransferUpdate) {
    // gives status of a payload
    // e.g success/failure/in_progress
    // bytes transferred and total bytes etc
  });
}
