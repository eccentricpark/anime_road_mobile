import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomDraggableSheet extends StatelessWidget {
  final ValueNotifier<int?> selectedIndex = ValueNotifier<int?>(null); // 상태 관리
  final Set<Marker> markerList;
  late List<Map<String, dynamic>> pilgrimageList;
  final void Function(LatLng position) onMarkerSelected;
  CustomDraggableSheet({Key? key, required this.markerList, required this.onMarkerSelected}) : super(key: key){
    
    // List로 변환한다. 
    // Set은 index 접근이 불가능하여, 리스트 내 아이템 위치를 찾을 수 없다.
    this.pilgrimageList = this.markerList.map((marker){
      return {
        'markerId' : marker.markerId.value,
        'latitude' : marker.position.latitude,
        'longitude' : marker.position.longitude,
        'title' : marker.infoWindow.title ?? ''
      };
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 0.35,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: ValueListenableBuilder<int?>(
            valueListenable: selectedIndex, // 선택 상태 구독
            builder: (context, selected, item) {
              return ListView.builder(
                controller: scrollController,
                itemCount: pilgrimageList.length,
                itemBuilder: (BuildContext context, int index) {
                  final bool isSelected = selected == index;

                  return GestureDetector(
                    onTap: () {
                      selectedIndex.value = index; // 상태 업데이트
                      final selectedPosition = LatLng(
                        pilgrimageList[index]['latitude'] as double,
                        pilgrimageList[index]['longitude'] as double
                      );
                      onMarkerSelected(selectedPosition);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue[100] : Colors.transparent,
                        border: isSelected
                            ? Border.all(color: Colors.blue, width: 2)
                            : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: ListTile(
                        leading: Icon(Icons.place),
                        title: Text('${pilgrimageList[index]['markerId']}'),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
