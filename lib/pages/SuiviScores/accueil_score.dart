import 'package:flutter/material.dart';
import 'package:tdahelpe/main.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:provider/provider.dart';

class AccueilScore extends StatefulWidget {
  const AccueilScore({super.key});

  @override
  State<AccueilScore> createState() => _AccueilScoreState();
}

class _AccueilScoreState extends State<AccueilScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "Avancement des quêtes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.amber,
          ),
        ),
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
      ),
      body: Center(
        child: Consumer<ScoreProvider>(
          builder: (context, scoreP, child) {
            return Column(
              children: [
                SizedBox(height: 50),
                Text("${scoreP.morningScore} score du matin"),
                Text("${scoreP.midiScore} score du midi"),
                Text("${scoreP.afternoonScore} score du après-midi"),
                Text("${scoreP.eveningScore} score du soir"),
                SizedBox(height: 10),
                Text("${scoreP.globalBingoScore} global bingo score"),
                SizedBox(height: 50),
                Text("${scoreP.tacheScore} tache score"),
                Text("${scoreP.globalScore} global score"),
              ],
            );
          },
        ),
      ),
    );
  }
}
