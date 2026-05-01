import 'package:flutter/material.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
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
         AppLocalizations.of(context)!.tireTache,
        context,
        "accueil",
        true,
        Icon(Icons.home)
      ),
      body: [Quetesfinales(), TacheListeAffichage()][_currentindex],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.textIn,
        backgroundColor: Colors.deepPurple,
        color: Colors.white,
        activeColor: Colors.white,
        initialActiveIndex: _currentindex,
        items: [
          TabItem(icon: Icons.casino_rounded, title: AppLocalizations.of(context)!.tirage,
          ),

          TabItem(icon: Icons.list_alt_rounded, title: AppLocalizations.of(context)!.liste,
          ),
        ],
        onTap: (int i) => setCurrentIndex(i),
      ),
    );
  }
}
