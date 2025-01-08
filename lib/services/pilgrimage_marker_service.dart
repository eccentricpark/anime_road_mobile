import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../apis/custom_http.dart';

/*
 * 성지 정보를 출력하는 마커리스트
 * HTTP 요청으로 성지 정보를 받아오고
 * 필요한 내용을 추출하여 마커에 저장한다.
 */
class PilgrimageMarkerService{

  final CustomHTTP customHTTP = CustomHTTP();

  PilgrimageMarkerService();

  Future<Set<Marker>> getPilgrimage() async {
    Set<Marker> markerList = {};
    try{
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
    } catch(e){
      print("Error occurred: $e");
      throw e;
    }
    
  }

  // getPilgrimageDataByAnimation
  Future<Set<Marker>> getPilgrimageDataByAnime(String animeName) async {
    Set<Marker> markerList = {};
    final List<dynamic> pilgrimageData = await customHTTP.getPilgrimageDataByAnime(animeName);
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