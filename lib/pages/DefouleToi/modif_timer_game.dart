import 'package:flutter/material.dart';
import 'package:tdahelpe/widget/form_nombre.dart';

class ModifTimerGame extends StatefulWidget {
  const ModifTimerGame({super.key});

  @override
  State<ModifTimerGame> createState() => _ModifTimerGameState();
}

class _ModifTimerGameState extends State<ModifTimerGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modification Timer")),
      body: Center(
        child: Form(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Saisie la durée souhaité du timer en seconde.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Nombre maximal de seconde : 600",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "⚠️ La modification va supprimer le record enregistré ⚠️",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                NumberForm(nbMax: 600, typechoice: "game"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
