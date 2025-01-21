import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker {
  late String markerId; // 마커 식별자
  late LatLng position; // 위도, 경도
  late String? description; // 애니 장면 설명, opening 같은 경우는 생략해도 되니까 null 허용
  late String animeScene; // 애니 장면
  late String? realScene; // 실제 위치 사진
  
  CustomMarker({
    required this.markerId,
    required this.position,
    required this.animeScene,
    required this.realScene,
    this.description
  }){}
}