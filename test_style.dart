import 'package:flutter/material.dart';

class TestStyle extends StatelessWidget {
  TestStyle({super.key});

  final gradient = LinearGradient(
    colors: [Colors.black, Colors.greenAccent, Colors.yellow],
  );

  final textStyle = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Center(
          child: ShaderMask(
            shaderCallback: (bounds) {
              return gradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              );
            },
            child: Text("CECI EST UN ESSAI", style: textStyle),
          ),
        ),
      ),
    );
  }
}



