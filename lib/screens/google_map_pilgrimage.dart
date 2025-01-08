import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../services/index.dart';
import '../widgets/index.dart';

class GoogleMapPilgrimage extends StatefulWidget {
  final String animeName;
  const GoogleMapPilgrimage({
    Key? key,
    required this.animeName
  }) : super(key: key);

  @override
  _GoogleMapPilgrimageState createState() => _GoogleMapPilgrimageState();
}

class _GoogleMapPilgrimageState extends State<GoogleMapPilgrimage> {
  Stream<Position>? positionStream;
  late String _animeName;
  late GoogleMapController mapController;
  late PositionPermissionChecker positionPermissionChecker;
  late PilgrimageMarkerService pilgrimageMarkerService; // 성지 정보 리스트를 가져옴

  final Set<Marker> markers = {}; // 성지 정보를 저장

  @override
  void initState() {
    super.initState();
    _animeName = widget.animeName;
    print(_animeName);
    positionPermissionChecker = PositionPermissionChecker();
    positionPermissionChecker.checkPermission();
    pilgrimageMarkerService = PilgrimageMarkerService();
  }

  // 성지 정보를 가져와 반영한다
  Future<void> setPilgrimageMarkers() async{
    Set<Marker> pilgrimageList = await pilgrimageMarkerService.getPilgrimageDataByAnime(_animeName);
    setState(() {
      markers.addAll(pilgrimageList);
    });
  }

  // 초기값이므로 딱 한 번만 호출되며, 이후 호출 될 일 없다.
  void _onMapCreated(GoogleMapController controller) {
    setPilgrimageMarkers();
    mapController = controller;
  }

  @override
  void dispose(){
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(35.679032, 139.769488), // 초기 위치는 서울역
              zoom: 8.0,
            ),
            markers: markers,
            buildingsEnabled: false,
            myLocationEnabled: true
          ),
          CustomDraggableSheet(markerList: markers, onMarkerSelected: (LatLng position){
            mapController.animateCamera(CameraUpdate.newLatLngZoom(position, 16));
          }),
        ],
      ),
      
    );
  }
}