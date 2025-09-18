import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/TacheHazard/quetesfinales.dart';
import 'package:flutter_application_1/providers/taches_provider.dart';

import 'package:provider/provider.dart';

class TirageFinal extends StatefulWidget {
  const TirageFinal({super.key});

  @override
  State<TirageFinal> createState() => _TirageFinalState();
}

class _TirageFinalState extends State<TirageFinal>
    with TickerProviderStateMixin {




      
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

  final List listTAche = [Text('a'), Text('b'), Text('c')];

  late AnimationController controllerAnimation;
  late Animation<double> _animation;
  late AnimationController _slideScaleController;

  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  late List listIndex;

  int repetitionTremblemement = 0;
  int currentCycle = 0;
  int indexChooseText = 0;
  int indfinal = 0;
  List<String> listFinale = [];
  int nbCycles = 0;

  @override
  void initState() {
    super.initState();

    controllerAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    _slideScaleController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 0,
      end: -300,
    ).animate(_slideScaleController);

    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_slideScaleController);

    _animation = Tween<double>(begin: -5, end: 10).animate(controllerAnimation);

    _slideScaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (currentCycle < nbCycles) {
          controllerAnimation.forward();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Quetesfinales(),
            ),
          );
        }
      }
    });

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        repetitionTremblemement++;
        if (repetitionTremblemement < 6) {
          controllerAnimation.reverse();
        } else {
          controllerAnimation.stop();
          repetitionTremblemement = 0;
        }
      } else if (status == AnimationStatus.dismissed) {
        repetitionTremblemement++;
        if (repetitionTremblemement < 6) {
          controllerAnimation.forward();
        } else {
          controllerAnimation.stop();
          repetitionTremblemement = 0;

          currentCycle++;
          _slideScaleController.reset();
          _slideScaleController.forward();
          indfinal = listIndex[currentCycle - 1];
        }
      }
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
          child: Text(
            "Liste d'activités",
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Center(
        child: Consumer<TachesProvider>(
          builder: (context, tacheP, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animation.value * math.pi / 180,
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset('assets/images/pochon.png'),
                      ),
                    );
                  },
                ),

                AnimatedBuilder(
                  animation: _slideScaleController,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..translateByDouble(
                          0.0,
                          _slideAnimation.value,
                          0.0,
                          1,
                        ) // Slide vertical
                        ..scaleByDouble(
                          _scaleAnimation.value,
                          _scaleAnimation.value,
                          1.0,
                          1.0,
                        ), // Scale
                      child: Text(tacheP.taches[indfinal].tacheName),
                    );
                  },
                ),

                ElevatedButton(
                  onPressed: () {
                    listIndex = tabIndice(
                      tacheP.nombreT,
                      tacheP.taches.length - 1,
                    );
                    nbCycles = tacheP.nombreT;

                    for (int i = 0; i < tacheP.nombreT; i++) {
                      int convertInt = (listIndex[i]);

                      listFinale.add(tacheP.taches[convertInt].tacheName);
                    }
                    tacheP.saveListeTache(listFinale);

                    setState(() {
                      controllerAnimation.forward();
                    });
                  },
                  child: Text("Tirer les tâches"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllerAnimation.dispose();
    _slideScaleController.dispose();
    super.dispose();
  }

  List tabIndice(nbChoiceadd, tacheLength) {
    int randomIndex;
    List listeIndex = [];
    List listToreturn = [];

    while (listToreturn.length < nbChoiceadd) {
      randomIndex = math.Random().nextInt(tacheLength);
      listeIndex.add(randomIndex);
      listToreturn = listeIndex.toSet().toList();
    }
    return listToreturn;
  }
}
