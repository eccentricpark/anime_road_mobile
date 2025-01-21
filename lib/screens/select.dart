import 'package:flutter/material.dart';
import './google_map.dart';
import '../widgets/three_button_column.dart';
import 'anime_list.dart';

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
          onThirdButtonPressed: () => _navigateGoogleMap(context))
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