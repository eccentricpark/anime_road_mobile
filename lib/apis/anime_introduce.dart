import 'dart:convert';
import 'package:http/http.dart' as http;
import './url.dart';

/*
 * HTTP 요청으로 필요한 정보를 받아옵니다.
 * 주로 데이터베이스 및 로그인처리를 담당합니다.
 *
 * */
class AnimeIntroduceAPI {
  AnimeIntroduceAPI();

  Future<dynamic> getAll() async {
    final url = Uri.parse("${BASE_URL}/anime-introduce");
    try {
      final response = await http.get(url).timeout(Duration(seconds: 5)); // GET 요청
      if (response.statusCode == 200) {
        final Map<String, dynamic> local = json.decode(response.body);
        return local['data'];
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  Future<dynamic> getByAnimeName(String animeName) async {
    final url = Uri.parse("${BASE_URL}/anime-introduce/${animeName}");
    try{
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> local = json.decode(response.body);
        print(local['data']);
        return local['data'];
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch(e) {
      print("Error occurred: $e");
    }
  }
}
