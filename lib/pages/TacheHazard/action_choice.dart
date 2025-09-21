import 'package:flutter/material.dart';


class ActionChoice extends StatefulWidget {
  const ActionChoice({super.key});

  @override
  State<ActionChoice> createState() => _ActionChoiceState();
}

class _ActionChoiceState extends State<ActionChoice> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Prêt pour le tirage?',
            style: TextStyle(fontSize: 50),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {},
            child: Text('Procéder au tirage'),
          ),
          
        
        ],
      ),
    );
  }
}
