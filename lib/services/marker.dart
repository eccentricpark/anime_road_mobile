import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../apis/custom_http.dart';


class CustomMarkerList{

  final CustomHTTP customHTTP = CustomHTTP();

  CustomMarkerList();

  Future<Set<Marker>> getPilgrimage() async {
    Set<Marker> markerList = {};
    final List<dynamic> pilgrimageData = await customHTTP.getPilgrimageLocation();
    for (var item in pilgrimageData){
      final double latitude = double.parse(item['latitude']);
      final double longitude = double.parse(item['longitude']);
      Marker marker = Marker(
        markerId: MarkerId(item['anime_scene_number']),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(
            title: item['anime_scene_number'],
            snippet: "f"
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
      markerList.add(marker);
    }
    return markerList;
  }

  // getPilgrimageDataByAnimation
  Future<Set<Marker>> getPilgrimageDataByAnimation(String animationName) async {
    Set<Marker> markerList = {};
    final List<dynamic> pilgrimageData = await customHTTP.getPilgrimageDataByAnimation(animationName);
    for (var item in pilgrimageData){
      final double latitude = double.parse(item['latitude']);
      final double longitude = double.parse(item['longitude']);
      Marker marker = Marker(
        markerId: MarkerId(item['anime_scene_number']),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(
            title: item['anime_scene_number'],
            snippet: "f"
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
      markerList.add(marker);
    }
    return markerList;
  }
}