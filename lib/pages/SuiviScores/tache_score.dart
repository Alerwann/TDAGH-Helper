import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/providers/score_provider.dart';

class TacheScore extends StatefulWidget {
  const TacheScore({super.key});

  @override
  State<TacheScore> createState() => _TacheScoreState();
}

class _TacheScoreState extends State<TacheScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "T'es pas tâche",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Consumer<ScoreProvider>(
        builder: (context, scoreP, child) {
         return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("hello")
              ],
            ),
          );
        },
      ),
    );
  }
}
