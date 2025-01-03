import 'package:flutter/material.dart';
import '../apis/anime_introduce.dart';
import 'anime_introduce.dart';

class AnimeList extends StatelessWidget {
  final AnimeIntroduceAPI animeIntroduceAPI = AnimeIntroduceAPI();
  final double titleFontSize = 16;
  final double containerHeight = 250;
  final double containerWidth = 310;

  // 클릭된 아이템 인덱스를 관리하는 ValueNotifier
  final ValueNotifier<int?> selectedIndexNotifier = ValueNotifier<int?>(null);
  
  // 샘플 데이터: DB나 API에서 가져온 데이터를 대신함
  // 추후 DB를 연결하여 정보를 가져와야 함.
  final List<Map<String, String>> animeList = [
    {
      "image": "https://storage.googleapis.com/anime_road/animation_list/BOCCHI_THE_ROCK.png",
      "title": "봇치 더 락",
    },
    {
      "image": "https://storage.googleapis.com/anime_road/animation_list/OSI_NO_KO.png",
      "title": "최애의 아이 ",
    },
    {
      "image": "https://storage.googleapis.com/anime_road/animation_list/SOUND_EUPHONIUM.png",
      "title": "울려라 유포니엄",
    },
    {
      "image": "https://storage.googleapis.com/anime_road/animation_list/TYING_THE_KNOT_WITH_AN_AMAGAMI_SISTER.png",
      "title": "아마가미 씨네 인연맺기",
    },
    {
      "image": "https://storage.googleapis.com/anime_road/animation_list/ZOMBIELAND_SAGA.png",
      "title": "좀비랜드 사가",
    },
  ];

  void gestureNavigation(BuildContext context, int index){
    selectedIndexNotifier.value = index;
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => AnimeIntroduce(data: animeList[index]['title'])
      )
    );
  }

  Widget renderItem(BuildContext context, dynamic anime, int index){
    return Padding(
      padding: EdgeInsets.all(10),
      child: ValueListenableBuilder<int?>(
        valueListenable: selectedIndexNotifier,
        builder: (context, selectedIndex, _) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.blue[50],
              // 클릭된 아이템에만 테두리 표시
              border: selectedIndex == index
                  ? Border.all(color: Colors.red, width: 3) // 클릭된 경우 테두리
                  : null, // 기본 상태는 테두리 없음
              borderRadius: BorderRadius.circular(10)
            ),
            child: SizedBox(
              width: containerWidth,
              height: containerHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 150,
                      child: Center(
                        child: Image.network(
                          anime["image"],
                          errorBuilder: (context, error, stackTrace){
                            return const Text("로드 실패");
                          },
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        width: 150,
                        child: Center(
                          child: Text(
                            anime["title"] ?? "제목 없음",
                            softWrap: true,
                            maxLines: 5,
                            style: TextStyle(
                              fontSize: titleFontSize,
                            ),
                          ),
                        ),
                      )                        
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          shrinkWrap: true, // 내부 스크롤 문제 방지
          itemCount: animeList.length,
          itemBuilder: (context, index) {
            final anime = animeList[index];
            return GestureDetector(
              onTap: () => gestureNavigation(context, index),
              child: renderItem(context, anime, index),
            );
          },
        ),
      ),
    );
  }
}
