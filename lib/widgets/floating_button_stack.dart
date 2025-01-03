import 'package:flutter/material.dart';


class FloatingButtonStack extends StatelessWidget{
  final VoidCallback onMyLocationPressed;
  final VoidCallback onDirectionPressed;

  const FloatingButtonStack({
    Key? key,
    required this.onMyLocationPressed,
    required this.onDirectionPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 80,
          right: 10,
          child: FloatingActionButton(
            heroTag: 'my_location',
            child: Icon(Icons.my_location),
            onPressed: onMyLocationPressed,
          )
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child: FloatingActionButton(
            heroTag: 'direction',
            child: Icon(Icons.directions),
            onPressed: onDirectionPressed,
          )
        )
      ],
    );
  }
}