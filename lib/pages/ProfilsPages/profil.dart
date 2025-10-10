import 'package:tdahelpe/pages/ProfilsPages/heures_parametre.dart';
import 'package:tdahelpe/pages/ProfilsPages/profil_parametre.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/widget/imageSet.dart';
import 'package:flutter/material.dart';

import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "Gestion du profil",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.amber,
          ),
        ),

      ),
      body: Column(
        spacing: 2,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<ProfilProvider>(
            builder: (context, profil, child) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: ImageSet(sizewidth: 150, 0),
                  ),
                  Text(
                    profil.pseudo,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 60),
                  ),
                ],
              );
            },
          ),

          SizedBox(height: 30),

          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilParametreConfig(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(fixedSize: Size(350, 60)),
              child: Row(
                children: [
                  Icon(
                    HugeIconsStroke.manWoman,
                    size: 40,
                    color: Color.fromARGB(225, 1, 112, 81),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Gère ton profil',
                    style: TextStyle(
                      color: Color.fromARGB(225, 1, 112, 81),
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HeureParametreConfig(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(fixedSize: Size(350, 60)),
              child: Row(
                children: [
                  Icon(
                    HugeIconsStroke.hourglass,
                    size: 40,
                    color: Color.fromARGB(225, 1, 112, 81),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Choix des heures',
                    style: TextStyle(
                      color: Color.fromARGB(225, 1, 112, 81),
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
