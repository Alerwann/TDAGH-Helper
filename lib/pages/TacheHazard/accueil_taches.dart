import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/TacheHazard/action_choice.dart';
import 'package:flutter_application_1/pages/TacheHazard/quetesfinales.dart';
import 'package:flutter_application_1/pages/TacheHazard/tache_liste_affichage.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class AccueilTaches extends StatefulWidget {
  const AccueilTaches({super.key});

  @override
  State<AccueilTaches> createState() => _AccueilTachesState();
}

class _AccueilTachesState extends State<AccueilTaches> {
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
  int _currentindex = 0;
  setCurrentIndex(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) {
            return gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            );
          },
          child: Text("Fais pas tache".toUpperCase(), style: textStyle),
        ),
      ),
      body: [
        ActionChoice(),
        TacheListeAffichage(),

        Quetesfinales(),
      ][_currentindex],
      bottomNavigationBar: ConvexAppBar(
        // Augmenter la hauteur pour accommoder le texte
        style: TabStyle.react,
        backgroundColor: Colors.deepPurple,
        color: Colors.white,
        activeColor: Colors.white,
        initialActiveIndex: _currentindex,
        items: [
          TabItem(icon: Icons.home, title: 'Choix'),
          TabItem(
            icon: Icons.settings,
            title: 'Paramètres', // Texte plus court
          ),

          TabItem(icon: Icons.list_rounded, title: 'Liste'),
        ],
        onTap: (int i) => setCurrentIndex(i),
      ),
    );
  }
}
