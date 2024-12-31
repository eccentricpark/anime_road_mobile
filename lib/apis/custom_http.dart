import 'dart:convert';
import 'package:http/http.dart' as http;

/*
 * HTTP 요청으로 필요한 정보를 받아옵니다.
 * 주로 데이터베이스 및 로그인처리를 담당합니다.
 *
 * */
class CustomHTTP {
  List<dynamic> data = [];
  final BASE_URL='http://172.30.1.38:3000';

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
    }
  }

  Future<dynamic> getPilgrimageDataByAnimation(String animationName) async {
    final url = Uri.parse("${BASE_URL}/kantolocation/${animationName}"); // API URL
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
    }
  }

  Future<dynamic> testDB() async {
    final url = Uri.parse("${BASE_URL}/kantolocation"); // API URL
    try {
      final response = await http.post(url, body:{}); // GET 요청
      if (response.statusCode == 200) {
        print(json.decode(response.body)); // JSON 파싱
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }
}
