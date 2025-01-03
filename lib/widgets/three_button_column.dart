import 'package:flutter/material.dart';

class ThreeButtonColumn extends StatelessWidget {
  final VoidCallback? onFirstButtonPressed;
  final VoidCallback? onSecondButtonPressed;
  final VoidCallback? onThirdButtonPressed;

  const ThreeButtonColumn({
    Key? key,
    this.onFirstButtonPressed,
    this.onSecondButtonPressed,
    this.onThirdButtonPressed
  }) : super(key: key);

  void _defaultFirstAction(){
    print("Default First Action");
  }
  void _defaultSecondAction(){
    print("Default Second Action");
  }
  void _defaultThirdAction(){
    print("Default Third Action");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: onFirstButtonPressed ?? _defaultFirstAction,
            child: const Text("성지 목록 보기", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: onSecondButtonPressed ?? _defaultSecondAction,
            child: const Text("나만의 성지 목록", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: onThirdButtonPressed ?? _defaultThirdAction,
            child: const Text("지도 보기", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ),

      ],
    );
  }
}
