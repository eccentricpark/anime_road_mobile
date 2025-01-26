import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../apis/anime_introduce.dart';
import '../screens/google_map_pilgrimage.dart';

class AnimeIntroduce extends StatelessWidget {
  final title; // 타입 명시
  final content;
  final ScrollController controller = ScrollController();
  final AnimeIntroduceAPI animeIntroduceAPI = AnimeIntroduceAPI();
  AnimeIntroduce({
    Key? key,
    required this.title,
    required this.content
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
            Padding(
              padding: EdgeInsets.all(10),
              child: buildTitle(),
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

  // 화면 상단 가운데 애니 제목 표시
  Widget buildTitle(){
    return SizedBox(
      height: 200,
      child: Center(
        child: Text(
          title, 
          style: TextStyle(
            fontSize: 20
          ),
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
