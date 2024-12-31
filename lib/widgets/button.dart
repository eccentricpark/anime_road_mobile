import 'package:flutter/material.dart';
import '../screens/google_map.dart';
import '../apis/custom_http.dart';


class ThreeButtonColumn extends StatelessWidget {
  const ThreeButtonColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: (){
              print("Button");
            },
            child: const Text("성지 목록 보기", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: (){
              print("Button");
            },
            child: const Text("나만의 성지 목록", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoogleMapCustom())
              );
            },
            child: const Text("지도 보기", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ),

      ],
    );
  }
}
