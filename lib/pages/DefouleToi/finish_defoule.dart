import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/DefouleToi/defoule_toi.dart';
import 'package:flutter_application_1/providers/defoule_provider.dart';

import 'package:provider/provider.dart';

class FinishDefoule extends StatefulWidget {
  final int score;
  const FinishDefoule({super.key, required this.score});

  @override
  State<FinishDefoule> createState() => _FinishDefouleState();
}

class _FinishDefouleState extends State<FinishDefoule> {
  bool bestRecord = false;
  final gradient = LinearGradient(
    colors: [
      const Color.fromARGB(255, 237, 85, 2),
      const Color.fromARGB(255, 244, 176, 4),
      const Color.fromARGB(255, 255, 85, 59),
    ],
  );

  final textStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return Consumer<DefouleProvider>(
      builder: (context, defouleP, child) {
        if (defouleP.scoreDefoule < widget.score) {
          bestRecord = true;
          defouleP.saveScore(widget.score);
        }
        return Scaffold(
          appBar: AppBar(
            title: ShaderMask(
              shaderCallback: (bounds) {
                return gradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                );
              },
              child: Text("Tappe et défoule toi", style: textStyle),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tu as  un score de : ${widget.score} tapes !",
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                bestRecord == true
                    ? Text(
                        "Tu as batut le record",
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      )
                    : Text(
                        "Le record est de ${defouleP.scoreDefoule} tapes.",
                        style: TextStyle(fontSize: 25),
                      ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeDefouleToi()),
                    );
                  },
                  child: Text("Réessayer"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                  child: Text("Retour à l'accueil"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
