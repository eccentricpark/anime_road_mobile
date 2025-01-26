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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("애니메이션 목록"),
      ),
      body: FutureBuilder(
        future: animeIntroduceAPI.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) {
            return const Center(child: Text("데이터를 불러오는 중 오류 발생"));
          } 
          else {
            final animeList = snapshot.data ?? [];
            return ListView.builder(
              itemCount: animeList.length,
              itemBuilder: (context, index) {
                return renderItem(context, animeList[index]);
              },
            );
          }
        },
      ),
    );
  }

  // 애니 클릭 시, 소개 화면으로 이동
  void moveToAnimeIntroduce(BuildContext context, String title, String content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimeIntroduce(title: title, content: content),
      ),
    );
  }

  // 애니 목록 표시
  Widget renderItem(BuildContext context, Map<String, dynamic> anime) {
    return GestureDetector(
      onTap: () => moveToAnimeIntroduce(context, anime['anime_korean_name'], anime['content_korean']),
      child: Padding(
        padding: const EdgeInsets.all(10),

        // 리스트 뷰 아이템 표시 
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),

          // 왼쪽은 애니 이미지, 오른쪽은 애니 제목
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Image.network(
                  anime['anime_image'],
                  errorBuilder: (context, error, stackTrace) => const Text("로드 실패"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 150,
                  child: Text(
                    anime['anime_korean_name'],
                    style: TextStyle(fontSize: titleFontSize),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

