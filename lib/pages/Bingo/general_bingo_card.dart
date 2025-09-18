import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/list/bingocard_list.dart';
import 'package:flutter_application_1/providers/score_provider.dart';
import 'package:flutter_application_1/services/score_storage_service.dart';
import 'package:flutter_application_1/widget/simpleflipcard.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:pretty_animated_text/pretty_animated_text.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BingoGamePreview extends StatefulWidget {
  final String titleMoment;

  const BingoGamePreview({super.key, required this.titleMoment});

  @override
  State<BingoGamePreview> createState() => _BingoGamePreviewState();
}

class _BingoGamePreviewState extends State<BingoGamePreview>
    with TickerProviderStateMixin {
  late List<dynamic> bingoCards;
  late int affichescore;
  late AnimationController _celebrationController;
  bool _showAnimation = false;
  bool _isLoading = true; // Pour afficher un loader pendant le chargement

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Initialiser les données avec les sauvegardes
  Future<void> _initializeData() async {
    // Charger les cartes par défaut
    switch (widget.titleMoment) {
      case 'Matin':
        bingoCards = BingoDataMorning.getDefaultCards();
        break;
      case 'Midi':
        bingoCards = BingoDataMidi.getDefaultCards();
        break;
      case 'Soir':
        bingoCards = BingoDataSoir.getDefaultCards();
        break;
      case 'Couché':
        bingoCards = BingoDataCouche.getDefaultCards();
        break;
      default:
        bingoCards = BingoDataMorning.getDefaultCards();
    }

    // Charger l'état sauvegardé des cartes
    final savedStates = await ScoreStorageService.getCardsState(
      widget.titleMoment,
      bingoCards.length,
    );

    // Appliquer l'état sauvegardé aux cartes
    for (int i = 0; i < bingoCards.length && i < savedStates.length; i++) {
      bingoCards[i].isFlipped = savedStates[i];
    }

    _celebrationController = AnimationController(vsync: this);

    _celebrationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showAnimation = false;
          _celebrationController.reset();
        });
      }
    });

    setState(() {
      _isLoading = false;
    });
  }

  // Sauvegarder l'état des cartes
  Future<void> _saveCardsState() async {
    final List<bool> states = [];
    for (var card in bingoCards) {
      states.add(card.isFlipped);
    }
    await ScoreStorageService.saveCardsState(widget.titleMoment, states);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ScoreProvider>(context);

    // Récupérer le bon score selon le moment
    switch (widget.titleMoment) {
      case 'Matin':
        affichescore = appState.morningScore;
        break;
      case 'Midi':
        affichescore = appState.midiScore;
        break;
      case 'Soir':
        affichescore = appState.afternoonScore;
        break;
      case 'Couché':
        affichescore = appState.eveningScore;
        break;
    }

    // Afficher un loader pendant le chargement
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Retour')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Retour')),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                SpringText(
                  text: widget.titleMoment,
                  duration: const Duration(milliseconds: 2000),
                  type: AnimationType.word,
                  textStyle: TextStyle(
                    fontSize: 50,
                    fontFamily: 'Metamorphous',
                    foreground: Paint()
                      ..shader = ui.Gradient.linear(
                        const Offset(0, 20),
                        const Offset(150, 20),
                        <Color>[
                          const ui.Color.fromARGB(255, 2, 236, 96),
                          const ui.Color.fromARGB(255, 2, 174, 125),
                        ],
                      ),
                  ),
                ),
                SizedBox(height: 20),
                CircularStepProgressIndicator(
                  totalSteps: bingoCards.length,
                  currentStep: affichescore,
                  selectedColor: const ui.Color.fromARGB(255, 0, 245, 0),
                  unselectedColor: const ui.Color.fromARGB(255, 255, 0, 0),
                  padding: 0,
                  height: 75,
                  width: 85,
                  child: Icon(HugeIconsSolid.alien01),
                ),
                SizedBox(height: 50),
                Text("Score : $affichescore/${bingoCards.length}"),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                    itemCount: bingoCards.length,
                    itemBuilder: (context, index) {
                      return SimpleFlipCard(
                        cardData: bingoCards[index],
                        isFlipped: bingoCards[index].isFlipped,
                        onTap: () async {
                          setState(() {
                            if (bingoCards[index].isFlipped) {
                              // La carte était retournée, on la remet
                              Provider.of<ScoreProvider>(
                                context,
                                listen: false,
                              ).decrementglobal(
                                widget.titleMoment.toLowerCase(),
                              );
                            } else {
                              // La carte n'était pas retournée, on la retourne
                              Provider.of<ScoreProvider>(
                                context,
                                listen: false,
                              ).incrementglobal(
                                widget.titleMoment.toLowerCase(),
                              );
                            }

                            bingoCards[index].isFlipped =
                                !bingoCards[index].isFlipped;
                          });

                          // Sauvegarder l'état des cartes après chaque changement
                          await _saveCardsState();

                          // Vérifier si toutes les cartes sont retournées
                          final newScore = bingoCards
                              .where((card) => card.isFlipped)
                              .length;
                          if (newScore == bingoCards.length) {
                            _showAnimation = true;
                            _celebrationController.duration = Duration(
                              milliseconds: 3000,
                            );
                            _celebrationController.forward();
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (_showAnimation)
            Center(
              child: Lottie.asset(
                'assets/animations/Confetti-Animation.json',
                controller: _celebrationController,
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }
}
