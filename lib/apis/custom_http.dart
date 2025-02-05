import 'dart:convert';
import 'package:http/http.dart' as http;
import './url.dart';

/*
 * HTTP 요청으로 필요한 정보를 받아옵니다.
 * 주로 데이터베이스 및 로그인처리를 담당합니다.
 *
 * */
class CustomHTTP {
  List<dynamic> data = [];

  // 지역 내 모든 성지 정보를 가져 온다.
  Future<dynamic> getPilgrimageLocation() async {
    final url = Uri.parse("${BASE_URL}/kantolocation"); // API URL
    try {
      final response = await http.get(url); // GET 요청
      if (response.statusCode == 200) {
        final Map<String, dynamic> local = json.decode(response.body);
        return local['data'];
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
      throw e;
    }
  }

  Future<dynamic> getPilgrimageDataByAnime(String animeName) async {
    print("${BASE_URL}/kantolocation/${animeName}");
    final url = Uri.parse("${BASE_URL}/kantolocation/${animeName}"); // API URL
    try {
      final response = await http.get(url); // GET 요청
      if (response.statusCode == 200) {
        final Map<String, dynamic> local = json.decode(response.body);
        return local['data'];
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
      throw e;
    }
  }
}
