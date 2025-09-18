import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Bingo/general_bingo_card.dart';
import 'package:flutter_application_1/providers/score_provider.dart';
import 'package:flutter_application_1/providers/heures_profil_provider.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';

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

    final midi = DateTime(now.year, now.month, now.day, 12);
    final afternoon = DateTime(now.year, now.month, now.day, 18);
    final couche = DateTime(now.year, now.month, now.day, 21);

    bool isMatinActive = now.isBefore(midi.add(Duration(hours: 1)));
    bool isMidiActive =
        now.isAfter(midi) && now.isBefore(afternoon.add(Duration(hours: 1)));
    bool isSoirActive =
        now.isAfter(afternoon) &&
        now.isBefore(couche.add(Duration(minutes: 1)));
    bool isCoucheActive = now.isAfter(couche);

    final colorizeColors = [
      Colors.purple,
      Colors.blue,
      const Color.fromARGB(255, 1, 236, 87),
      const Color.fromARGB(255, 3, 243, 231),
    ];

    final colorizeTextStyle = TextStyle(fontSize: 50.0, fontFamily: 'Horizon');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,

        title: SizedBox(
          width: 500.0,
          child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                'Bingo',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
                textAlign: TextAlign.center,
                speed: Duration(seconds: 1),
              ),
              ColorizeAnimatedText(
                'Quotidien',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
                textAlign: TextAlign.center,
                speed: Duration(seconds: 1),
              ),
            ],
            isRepeatingAnimation: true,
            repeatForever: true,
          ),
        ),
        backgroundColor: const Color.fromARGB(155, 193, 187, 187),
      ),

      body: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 30,

            children: [
              Text(
                "Score du jour : ",
                style: TextStyle(
                  fontFamily: "StoryScript",
                  fontSize: 50,
                  letterSpacing: 0.01,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Consumer<ScoreProvider>(
                builder: (context, appState, child) {
                  return Text(
                    "${appState.globalScore} / 16",
                    style: TextStyle(fontSize: 30, fontFamily: "StoryScript"),
                  );
                },
              ),

              // matin
              _buildMomentButton(
                'Matin',
                HugeIconsSolid.sun02,
                Color.fromARGB(255, 230, 120, 50),
                isMatinActive,
              ),

              //midi
              _buildMomentButton(
                'Midi',
                HugeIconsSolid.apple01,
                Color.fromARGB(255, 255, 0, 0),
                isMidiActive,
              ),
              //soir
              _buildMomentButton(
                'Soir',
                HugeIconsSolid.moon02,
                Color.fromARGB(255, 255, 226, 63),
                isSoirActive,
              ),

              //couché
              _buildMomentButton(
                'Couché',
                HugeIconsSolid.star,
                Color.fromARGB(255, 255, 255, 0),
                isCoucheActive,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMomentButton(
    String moment,
    IconData icon,
    Color iconColor,
    bool isActive,
  ) {
    int hourMomentdeb = 12;
    int hourMomentfin = 12;

    return ElevatedButton(
      onPressed: isActive
          ? () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BingoGamePreview(titleMoment: moment),
              ),
            )
          : null,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor),
              SizedBox(width: 10),
              Text(
                moment,
                style: TextStyle(
                  fontSize: 50,
                  color: const Color.fromARGB(255, 31, 74, 61),
                ),
              ),
              SizedBox(width: 10),
              Icon(icon, color: iconColor),
            ],
          ),
          Consumer<HeureProfilProvider>(
            builder: (context, profil, child) {
              switch (moment.toLowerCase()) {
                case 'matin':
                  hourMomentdeb = profil.reveilHours - 1;
                  hourMomentfin = profil.midiHours + 1;

                  break;
                case 'midi':
                  hourMomentdeb = profil.midiHours - 1;
                  hourMomentfin = profil.soirhours + 1;
                  break;
                case 'soir':
                  hourMomentdeb = profil.soirhours - 1;
                  hourMomentfin = profil.coucheHours + 1;

                  break;
                case 'couché':
                  hourMomentdeb = profil.coucheHours - 1;
                  hourMomentfin = profil.reveilHours + 1;

                  break;
              }
              return isActive
                  ? Text("Fin d'accès à $hourMomentfin H")
                  : Text("Ouverture à $hourMomentdeb H");
            },
          ),
        ],
      ),
    );
  }
}
