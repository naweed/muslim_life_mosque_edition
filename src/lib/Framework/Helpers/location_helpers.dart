import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationHelpers {
  static Future<bool> requestLocationermissions() async {
    bool permissionGranted = true;

    if (await Permission.locationWhenInUse.serviceStatus.isEnabled ||
        await Permission.location.serviceStatus.isEnabled ||
        await Permission.locationAlways.serviceStatus.isEnabled) {
      // Use location is enable
      // Check for permission
      if (!await Permission.location.status.isGranted) {
        Map<Permission, PermissionStatus> permissionStatuses = await [Permission.location].request();

        permissionGranted = permissionStatuses[Permission.location] != PermissionStatus.granted;
      }
    } else {
      permissionGranted = false;
    }

    return permissionGranted;
  }

  static Future<bool> locationermissionsGranted() async {
    bool permissionGranted = false;

    if (await Permission.locationWhenInUse.serviceStatus.isEnabled ||
        await Permission.location.serviceStatus.isEnabled ||
        await Permission.locationAlways.serviceStatus.isEnabled) {
      // Use location is enable
      // Check for permission
      permissionGranted = await Permission.location.status.isGranted;
    }

    return permissionGranted;
  }

  static Future<(double, double)> getLocationCoordinates() async {
    if (await requestLocationermissions()) {
      if (await Geolocator.isLocationServiceEnabled()) {
        var permission = await Geolocator.checkPermission();

        if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
          var coordinates = await Geolocator.getCurrentPosition();

          return (coordinates.latitude, coordinates.longitude);
        }
      }
    }

    return (0.0, 0.0);
  }
}
