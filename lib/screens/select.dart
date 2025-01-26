import 'package:flutter/material.dart';
import './google_map.dart';
import '../widgets/three_button_column.dart';
import 'anime_list.dart';

/// 앱 초기 화면입니다.
/// 
/// 알파 단계이므로, 애니 성지 목록 보기만 나옵니다.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {/* 설정 버튼 클릭 시 동작*/},
          ),
        ],
      ),
      body: Center(
        child: ThreeButtonColumn(
          onFirstButtonPressed: () => _navigateAnimeList(context),
        )
      ),
    );
  }

  void _navigateAnimeList(BuildContext context){
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => AnimeList()
      )
    );
  }

  void _navigateGoogleMap(BuildContext context){
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => GoogleMapCustom()
      )
    );
  }
}