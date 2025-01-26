import 'package:flutter/material.dart';

class ThreeButtonColumn extends StatelessWidget {
  final VoidCallback? onFirstButtonPressed;
  final VoidCallback? onSecondButtonPressed;

  const ThreeButtonColumn({
    Key? key,
    this.onFirstButtonPressed,
    this.onSecondButtonPressed,
  }) : super(key: key);

  
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
        

      ],
    );
  }
  void _defaultFirstAction(){print("Default First Action");}
  // void _defaultSecondAction(){print("Default Second Action");}
}
