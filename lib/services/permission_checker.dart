import 'package:geolocator/geolocator.dart';

/*
 * 위치 정보 관련 권한 체크 
 */
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