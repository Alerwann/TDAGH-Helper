import 'package:flutter/material.dart';
import 'package:tdahelpe/pages/TacheHazard/tirage_taches.dart';
import 'package:tdahelpe/pages/TacheHazard/tache_liste_affichage.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';

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
  void setCurrentIndex(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        "Fais pas tâche",
        context,
        "accueil",
        true,
      ),
      body: [Quetesfinales(), TacheListeAffichage()][_currentindex],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.textIn,
        backgroundColor: Colors.deepPurple,
        color: Colors.white,
        activeColor: Colors.white,
        initialActiveIndex: _currentindex,
        items: [
          TabItem(icon: Icons.casino_rounded, title: 'Tirage'),

          TabItem(icon: Icons.list_alt_rounded, title: 'Liste'),
        ],
        onTap: (int i) => setCurrentIndex(i),
      ),
    );
  }
}
