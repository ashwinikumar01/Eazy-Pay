import 'package:nearby_connections/nearby_connections.dart';

Future<bool> getLocationPermission() async {
  bool b = await Nearby().checkLocationEnabled();
  if (b)
    return true;
  else {
    bool a = await Nearby().enableLocationServices();
    if (a)
      return true;
    else
      return false;
  }
}

Future<bool> getStoragePermission() async {
  bool b = await Nearby().checkExternalStoragePermission();

  if (b)
    return true;
  else {
    await Nearby().askExternalStoragePermission();
    return true;
  }
}
