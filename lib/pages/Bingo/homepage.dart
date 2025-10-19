
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/widget/specific/moment_button.dart';
import 'package:tdahelpe/widget/utils/custom_height_appcar.dart';

class HomeBingoPage extends StatefulWidget {
  const HomeBingoPage({super.key});

  @override
  State<HomeBingoPage> createState() => _HomeBingoPageState();
}

class _HomeBingoPageState extends State<HomeBingoPage> {

  var choiceBingo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightAppcar.customApp(
        "Bingo Quotidien",
        context,
        "accueil",
        true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Consumer<HeureProfilProvider>(
            builder: (context, heureP, child) {
              return Column(
                spacing: 30,

                children: [
                  MomentButton.buildMomentButton(
                    'Matin',
                    HugeIconsSolid.sun02,
                    Color.fromARGB(255, 53, 252, 252),
                    context,
                  ),

                  MomentButton.buildMomentButton(
                    'Midi',
                    HugeIconsSolid.apple01,
                    Color.fromARGB(255, 255, 0, 0),
                    context,
                  ),
                  //soir
                  MomentButton.buildMomentButton(
                    'Soir',
                    HugeIconsSolid.moon02,
                    Color.fromARGB(255, 255, 226, 63),
                    context,
                  ),

                  //couché
                  MomentButton.buildMomentButton(
                    'Couché',
                    HugeIconsSolid.star,
                    Color.fromARGB(255, 255, 255, 0),
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
