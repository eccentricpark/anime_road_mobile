import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/draggable_sheet.dart';
import '../services/index.dart';

class GoogleMapCustom extends StatefulWidget {
  const GoogleMapCustom({Key? key}) : super(key: key);

  @override
  _GoogleMapCustomState createState() => _GoogleMapCustomState();
}

class _GoogleMapCustomState extends State<GoogleMapCustom> {
  Stream<Position>? positionStream;

  late GoogleMapController mapController;
  late PositionPermissionChecker positionPermissionChecker;
  late CustomMarkerList customMarkerList; // 성지 정보 리스트를 가져옴
  late MutableMyPosition mutableMyPosition;

  final Set<Marker> markers = {}; // 성지 정보를 저장

  @override
  void initState() {
    super.initState();
    positionPermissionChecker = PositionPermissionChecker();
    mutableMyPosition = MutableMyPosition();
    positionPermissionChecker.checkPermission();
    customMarkerList = CustomMarkerList();

    mutableMyPosition.trackMyLocation();
    mutableMyPosition.initializeLocation().then((_){
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(mutableMyPosition.getMyPosition(), 16)
      );
    });
    mutableMyPosition.updateLocation(2);
  }

  // 성지 정보를 가져와 반영한다
  Future<void> setPilgrimageMarkers() async{
    Set<Marker> pilgrimageList = await customMarkerList.getPilgrimage();
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
    mutableMyPosition.cancelTimer();
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
              target: LatLng(37.5548375992165, 126.971732581232), // 초기 위치는 서울역
              zoom: 14.0,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location),
        onPressed: (){
          mapController.animateCamera(CameraUpdate.newLatLngZoom(mutableMyPosition.getMyPosition(), 16));
        }
      ),
    );
  }
}