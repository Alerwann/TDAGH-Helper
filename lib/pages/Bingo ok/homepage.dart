import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/widget/specific/moment_button.dart';
import 'package:tdahelpe/widget/utils/text_degrade.dart';

class HomeBingoPage extends StatefulWidget {
  const HomeBingoPage({super.key});

  @override
  State<HomeBingoPage> createState() => _HomeBingoPageState();
}

class _HomeBingoPageState extends State<HomeBingoPage> {
  var choiceBingo = 0;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.home),
        ),

        title: TextDegrade(title: 'Bingo quotidien', choicetype: 'accueil'),
      ),

<<<<<<< HEAD
      body: SingleChildScrollView(
=======
      body: Card(
>>>>>>> refs/remotes/origin/main
        child: Center(
          child: Consumer<HeureProfilProvider>(
            builder: (context, heureP, child) {
              bool isMatinActive =
                  now.hour <= heureP.midiHours + 1 &&
                  now.hour >= heureP.reveilHours - 1;
              bool isMidiActive =
                  now.hour <= heureP.soirhours + 1 &&
                  now.hour >= heureP.midiHours - 1;
              bool isSoirActive =
                  now.hour <= heureP.coucheHours + 1 &&
                  now.hour >= heureP.soirhours - 1;
              bool isCoucheActive =
                  now.hour <= heureP.coucheHours + 3 &&
                  now.hour >= heureP.coucheHours - 1;
<<<<<<< HEAD
        
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 30,
        
=======

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 30,

>>>>>>> refs/remotes/origin/main
                children: [
                  MomentButton.buildMomentButton(
                    'Matin',
                    HugeIconsSolid.sun02,
                    Color.fromARGB(255, 53, 252, 252),
                    isMatinActive,
                    context,
                  ),
<<<<<<< HEAD
        
=======

>>>>>>> refs/remotes/origin/main
                  MomentButton.buildMomentButton(
                    'Midi',
                    HugeIconsSolid.apple01,
                    Color.fromARGB(255, 255, 0, 0),
                    isMidiActive,
                    context,
                  ),
                  //soir
                  MomentButton.buildMomentButton(
                    'Soir',
                    HugeIconsSolid.moon02,
                    Color.fromARGB(255, 255, 226, 63),
                    isSoirActive,
                    context,
                  ),
<<<<<<< HEAD
        
=======

>>>>>>> refs/remotes/origin/main
                  //couché
                  MomentButton.buildMomentButton(
                    'Couché',
                    HugeIconsSolid.star,
                    Color.fromARGB(255, 255, 255, 0),
                    isCoucheActive,
                    context,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
