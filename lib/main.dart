import 'package:flutter/material.dart';
import './screens/select.dart';
import './screens/anime_list.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MyApp(),
      home: AnimeList()
    )
  );
}