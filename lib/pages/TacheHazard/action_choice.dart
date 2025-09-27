import 'package:flutter/material.dart';

class ActionChoice extends StatefulWidget {
  const ActionChoice({super.key});

  @override
  State<ActionChoice> createState() => _ActionChoiceState();
}

class _ActionChoiceState extends State<ActionChoice> {
  String choice = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
            child: Column(
              children: [
                Text(
                  "Tu peux procéder directement au tirage quotidien en appuyant sur tirage ou paramètrer en la liste de tâche et le nombre de tirage dans paramètre.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 2,
                  ),
                ),

                SizedBox(height: 30),
                Text(
                  "⚠️ Si tu as déjà un tirage quotidien en cours, en modifiant la liste celui-ci sera annulé.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
