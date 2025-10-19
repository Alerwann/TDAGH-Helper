import 'dart:ui' as ui;
import 'package:tdahelpe/data/list/bingocard_list.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/services/score_storage_service.dart';
import 'package:tdahelpe/utils/horaire_moment.dart';
import 'package:tdahelpe/widget/specific/simpleflipcard.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';

class BingoGamePreview extends StatefulWidget {
  final String titleMoment;

  const BingoGamePreview({super.key, required this.titleMoment});

  @override
  State<BingoGamePreview> createState() => _BingoGamePreviewState();
}

class _BingoGamePreviewState extends State<BingoGamePreview>
    with TickerProviderStateMixin {
  late List<dynamic> bingoCards;
  // late int affichescore;
  late AnimationController _celebrationController;
  bool _showAnimation = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAccess();
    });
    _initializeData();
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  void _checkAccess() {
    if (!HoraireMoment.isMomentAccessible(widget.titleMoment, context)) {
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '⏰ La période ${widget.titleMoment} n\'est plus accessible',
          ),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _initializeData() async {
    try {
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
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur de chargement')));
      Navigator.pop(context);
    }
  }

  Future<void> _saveCardsState() async {
    final List<bool> states = [];
    for (var card in bingoCards) {
      states.add(card.isFlipped);
    }
    await ScoreStorageService.saveCardsState(widget.titleMoment, states);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Retour')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        widget.titleMoment,
        context,
        "accueil",
        true,
      ),
      body: Consumer<ScoreProvider>(
        builder: (context, scoreP, child) {
          int momentScore;
          switch (widget.titleMoment) {
            case 'Matin':
              momentScore = scoreP.morningScore;
              break;
            case 'Midi':
              momentScore = scoreP.midiScore;
              break;
            case 'Soir':
              momentScore = scoreP.afternoonScore;
              break;
            case 'Couché':
              momentScore = scoreP.eveningScore;
              break;
            default:
              momentScore = 0;
          }
          return Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      CircularStepProgressIndicator(
                        totalSteps: bingoCards.length,
                        currentStep: momentScore,
                        selectedColor: const ui.Color.fromARGB(255, 0, 245, 0),
                        unselectedColor: const ui.Color.fromARGB(
                          255,
                          255,
                          0,
                          0,
                        ),
                        padding: 0,
                        height: 100,
                        width: 100,
                        child: Icon(HugeIconsSolid.alien01),
                      ),
                      SizedBox(height: 50),

                      Expanded(
                        child: GridView.builder(
                          cacheExtent: 1000,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                              ),
                          itemCount: bingoCards.length,
                          itemBuilder: (context, index) {
                            return SimpleFlipCard(
                              cardData: bingoCards[index],
                              isFlipped: bingoCards[index].isFlipped,
                              onTap: () async {
                                setState(() {
                                  if (bingoCards[index].isFlipped) {
                                    scoreP.decrementglobal(
                                      widget.titleMoment.toLowerCase(),
                                    );
                                  } else {
                                    scoreP.incrementglobal(
                                      widget.titleMoment.toLowerCase(),
                                    );
                                  }

                                  bingoCards[index].isFlipped =
                                      !bingoCards[index].isFlipped;
                                });

                                await _saveCardsState();

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
          );
        },
      ),
    );
  }
}
