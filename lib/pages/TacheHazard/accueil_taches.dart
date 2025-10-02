import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/TacheHazard/action_choice.dart';
import 'package:flutter_application_1/pages/TacheHazard/quetes_finales.dart';
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
        Quetesfinales(),
        TacheListeAffichage(),
      ][_currentindex],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Colors.deepPurple,
        color: Colors.white,
        activeColor: Colors.white,
        initialActiveIndex: _currentindex,
        items: [
          TabItem(icon: Icons.question_mark_rounded, title: 'Choix'),
          TabItem(
            icon: Icons.play_arrow_sharp,
            title: 'Tirage', // Texte plus court
          ),

          TabItem(icon: Icons.settings, title: 'Paramètre'),
        ],
        onTap: (int i) => setCurrentIndex(i),
      ),
    );
  }
}
