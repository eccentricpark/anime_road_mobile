import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../apis/anime_introduce.dart';

class AnimeIntroduce extends StatelessWidget {
  final data; // 타입 명시
  final ScrollController controller = ScrollController();
  final AnimeIntroduceAPI animeIntroduceAPI = AnimeIntroduceAPI();
  AnimeIntroduce({
    Key? key,
    required this.data,
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
              child: SizedBox(
                height: 200,
                child: Center(
                  child: Text("봇치 더 락"),
                ),
              ),
            ),
            
            SizedBox(
              height: 50,
              child: Center(
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text("지도 보기"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 40)
                  ),
                ),
              )
              
            ),
            SizedBox(height: 20),
            // 아래 영역에 가득 차서 스크롤 되도록
            SizedBox(
              height: 400,
              child: Expanded(
                child: Markdown(
                  data: "크하하하",
                  selectable: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
