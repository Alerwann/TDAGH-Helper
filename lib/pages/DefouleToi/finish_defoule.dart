import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/DefouleToi/defoule_toi.dart';
import 'package:flutter_application_1/providers/defoule_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FinishDefoule extends StatefulWidget {
  final int score;
  const FinishDefoule({super.key, required this.score});

  @override
  State<FinishDefoule> createState() => _FinishDefouleState();
}

class _FinishDefouleState extends State<FinishDefoule> {
  bool bestRecord = false;
  bool enregistreRecord = true;
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
          defouleP.saveScore(widget.score);
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              icon: Icon(
                Icons.home,
                color: const Color.fromARGB(255, 230, 177, 2),
                size: 45,
              ),
            ),
            automaticallyImplyLeading: false,
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
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "Tu as  un score de : ${widget.score} tapes !",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),

                messageRecord(widget.score, defouleP.scoreDefoule),
                SizedBox(height: 50),
                Container(
                  height: 60,
                  width: 250,
                  margin: EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeDefouleToi(),
                        ),
                      );
                    },
                    child: Text("Réessayer", style: TextStyle(fontSize: 20)),
                  ),
                ),

                Container(
                  height: 60,
                  width: 250,
                  margin: EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        defouleP.resetScore();
                      });
                    },
                    child: Text("Remise à 0", style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget messageRecord(int scoreTape, int recordTape) {
    if (recordTape <= scoreTape) {
      return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          children: [
            Text(
              "Tu as batut le record",
              style: TextStyle(fontSize: 25, color: Colors.red),
            ),
            Text("🤗", style: TextStyle(fontSize: 60)),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          children: [
            Text(
              "Le record est de $recordTape tapes.",
              style: TextStyle(fontSize: 25),
            ),
            Text("😭", style: TextStyle(fontSize: 60)),
          ],
        ),
      );
    }
  }
}
