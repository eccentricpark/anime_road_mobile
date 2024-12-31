import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

/*
 * 위치 정보를 가져올 수 없다면 서울역으로 설정
 * 위치 관련 메타 데이터
 * 위치 추적 및 좌표 갱신은 여기서 처리
 * */
class MutableMyPosition{
  Stream<Position>? _positionStream;
  LatLng seoulStation = LatLng(37.5548375992165, 126.971732581232);
  late ValueNotifier<LatLng> _myPosition = ValueNotifier<LatLng>(seoulStation);
  MutableMyPosition();
  Timer? _timer;

  // 내 위치를 업데이트한다.
  void setMyPosition(LatLng newCoordinate){
    _myPosition.value = newCoordinate;
  }

  LatLng getMyPosition(){
    return LatLng(_myPosition.value.latitude, _myPosition.value.longitude);
  }

  // 현재 내 위치를 계속 추적한다.
  void trackMyLocation() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      )
    );
  }

  void cancelTimer(){
    _timer?.cancel();
  }

  // 위치 정보를 반영한다.
  void updateLocation(int updateDuration){
    _timer = Timer.periodic(Duration(seconds: updateDuration), (timer) async{
      Position position = await Geolocator.getCurrentPosition();
      setMyPosition(LatLng(position.latitude, position.longitude));
      print(getMyPosition().toString());
    });
  }

  // 5초 동안 위치 정보를 가져오고 실패 시 기본값(서울역) 설정
  Future<void> initializeLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException('5초 안에 위치를 가져오지 못했습니다.');
      });
      setMyPosition(LatLng(position.latitude, position.longitude));
    } catch (e) {
      print('위치 가져오기 실패: $e');
      setMyPosition(LatLng(37.5548375992165, 126.971732581232)); // 서울역
    }
  }
}