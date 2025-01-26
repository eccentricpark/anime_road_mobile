import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../apis/anime_introduce.dart';
import '../screens/google_map_pilgrimage.dart';

class AnimeIntroduce extends StatelessWidget {
  final title; // 타입 명시
  final content;
  final image;
  final ScrollController controller = ScrollController();
  final AnimeIntroduceAPI animeIntroduceAPI = AnimeIntroduceAPI();
  AnimeIntroduce({
    Key? key,
    required this.title, // 애니 제목, 성지 정보 호출에 필요
    required this.content, // 애니 이미지
    required this.image
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          // 상단에 표시할 것들
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: buildImage(),
            ),
            
            SizedBox(
              height: 50,
              child: buildMapButton(context),
            ),
            SizedBox(height: 20),
            // 아래 영역에 가득 차서 스크롤 되도록
            Expanded(
              child: Markdown(
                data: content,
                selectable: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 애니 이미지 빌드
  Widget buildImage(){
    return SizedBox(
      height: 200,
      child: Center(
        child: Image.network(
          image,
          errorBuilder: (context, error, stackTrace) => const Text("로드 실패"),
        ),
      ),
    );
  }

  // "지도 보기" 버튼 표시
  Widget buildMapButton(BuildContext context){
    return Center(
      child: ElevatedButton(
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => GoogleMapPilgrimage(animeName: title)
            )
          );
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(200, 40)
        ),
        child: Text("지도 보기"),
      ),
    );
  }

}
