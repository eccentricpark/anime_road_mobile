import 'package:anime_road/services/custom_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomDraggableSheet extends StatelessWidget {
  final ValueNotifier<int?> selectedIndex = ValueNotifier<int?>(null); // 상태 관리
  final ValueNotifier<Marker?> selectedMarker; // 선택된 마커 상태
  final Set<Marker> markerList;
  final void Function(LatLng position) onMarkerSelected;
  late ScrollController _scrollController;
  final List<CustomMarker> pilgrimageList;
  final double itemHeight = 200.0;
  final double marginVertical = 4.0;
  late double scrollSize = itemHeight + (marginVertical * 2);

  CustomDraggableSheet({
    Key? key, 
    required this.markerList, 
    required this.selectedMarker,
    required this.pilgrimageList,
    required this.onMarkerSelected
  }) : super(key: key){
    initMarkerListener();
  }


  /// 마커 클릭 시 리스트 항목 크기 만큼 해당 위치로 이동
  void scrollToIndex(int index) {
    _scrollController.animateTo(
      index * scrollSize, // 항목당 height 180, 마진 위아래 4가 적용 돼 총 188 차지
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  /// DraggableSheet의 스타일링 정의,
  /// 배경 색상은 white,
  /// 모서리는 둥글게 처리,
  /// 그림자 효과(boxShadow) 추가
  BoxDecoration buildDraggableSheetDecoration(){
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          offset: Offset(0, -5),
        ),
      ],
    );
  }

  /// 마커 클릭 시 해당 위치로 자동스크롤링
  void initMarkerListener(){
    selectedMarker.addListener((){
      final marker = selectedMarker.value;
      if(marker != null){
        final index = pilgrimageList.indexWhere(
          (item) => item.markerId == marker.markerId.value,
        );
        if(index != -1){
          selectedIndex.value = index;
          scrollToIndex(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.35,
      maxChildSize: 0.35,
      builder: (BuildContext context, ScrollController scrollController) {
        _scrollController = scrollController;
        return Container(
          decoration: buildDraggableSheetDecoration(),
          child: ValueListenableBuilder<int?>(
            valueListenable: selectedIndex, // 선택 상태 구독
            builder: (context, selected, item) {
              return renderPilgrimageList(selected);
            },
          ),
        );
      },
    );
  }

  /// Listview로 성지 목록 생성
  Widget renderPilgrimageList(int? selected){
    return ListView.builder(
      controller: _scrollController,
      itemCount: pilgrimageList.length,
      itemBuilder: (BuildContext context, int index) {
        final bool isSelected = selected == index;
        return GestureDetector(
          // 클릭한 아이템에 해당하는 마커 좌표로 이동
          onTap: () => moveToMarkerPosition(index),
          child: Container(
            height: 200,
            decoration: highlightBox(isSelected),
            margin: EdgeInsets.symmetric(vertical: marginVertical, horizontal: 8),
            // 각 아이템 항목 표시
            child: ListTile(
              leading: Icon(Icons.place),
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    SizedBox(
                      child: Image.network(
                        height: 150,
                        pilgrimageList[index].animeScene,
                        errorBuilder: (context, error, stackTrace) => const Text("로드 실패"),
                      ),
                    ),
                    Text('${pilgrimageList[index].description}', style: TextStyle(fontSize: 13),),
                  ],
                ),
              ),
              
            ),
          ),
        );
      },
    );
  }

	/// 클릭한 아이템의 해당 마커 좌표로 이동
  void moveToMarkerPosition(int index){
    selectedIndex.value = index; // 상태 업데이트
    final selectedPosition = pilgrimageList[index].position;
    onMarkerSelected(selectedPosition);
  }

  /// 리스트에서 클릭한 아이템 하이라이트
  BoxDecoration highlightBox(isSelected){
    return BoxDecoration(
      color: isSelected ? Colors.blue[100] : Colors.transparent,
      border: isSelected
          ? Border.all(color: Colors.blue, width: 2)
          : null,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
