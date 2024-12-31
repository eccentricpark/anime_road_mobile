import 'package:geolocator/geolocator.dart';

class PositionPermissionChecker{
  PositionPermissionChecker();

  Future<void> checkPermission()async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("serviceEnabled : $serviceEnabled");
    if(!serviceEnabled){
      LocationPermission permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location permission is required');
      }
    }
  }

}