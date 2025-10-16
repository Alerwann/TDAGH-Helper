import 'package:flutter/material.dart';

class TextDegrade extends StatelessWidget {
  final String title;
  final String choicetype;
  const TextDegrade( {super.key, required this.title, required this.choicetype});

  @override
  Widget build(BuildContext context) {
    final gradientAccueil = LinearGradient(
      colors: [
        const Color.fromARGB(255, 237, 85, 2),
        const Color.fromARGB(255, 244, 176, 4),
        const Color.fromARGB(255, 255, 85, 59),
      ],
    );

    final gradientParametre = LinearGradient(
      colors: [
        const Color.fromARGB(255, 124, 221, 169),
        const Color.fromARGB(255, 109, 189, 168),
        const Color.fromARGB(255, 150, 219, 222),
      ],
    );

    late LinearGradient gradient;

    switch (choicetype) {
      case "parametre":
        gradient = gradientParametre;
        break;
      case "accueil":
        gradient = gradientAccueil;
        break;
      default:
        gradient = gradientAccueil;
    }

    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
        softWrap: true,
        overflow: TextOverflow.visible, 
        maxLines: null,
        textAlign: TextAlign.center,
      ),
    );
  }
}
