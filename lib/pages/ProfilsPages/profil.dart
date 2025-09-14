import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/ProfilsPages/heures_parametre.dart';
import 'package:flutter_application_1/pages/ProfilsPages/profil_parametre.dart';
import 'package:flutter_application_1/providers/profil_provider.dart';

import 'package:flutter_application_1/widget/imageSet.dart';

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
      appBar: AppBar(),
      body: Column(
        spacing: 2,

        children: [
          Consumer<ProfilProvider>(
            builder: (context, profil, child) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: ImageSet(sizewidth: 150,0),
                  ),
                  Text(
                    profil.pseudo,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 70),
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
