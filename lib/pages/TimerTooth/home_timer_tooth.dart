import 'dart:async';
import 'dart:io' show Platform, File;
import 'package:flutter/foundation.dart';
import 'package:tdahelpe/data/list/music_list.dart';
import 'package:tdahelpe/data/schema/music_schema.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/providers/score_provider.dart';
import 'package:tdahelpe/providers/sound_provider.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';
import 'package:tdahelpe/widget/utils/imageSet.dart';
import 'package:flutter/material.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/widget/utils/loader_widget.dart';
import 'package:tdahelpe/widget/utils/text_degrade.dart';

class HomeTimertooth extends StatefulWidget {
  const HomeTimertooth({super.key});

  @override
  State<HomeTimertooth> createState() => _HomeTimertoothState();
}

class _HomeTimertoothState extends State<HomeTimertooth>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late SoundProvider _audioProvider;

  final Duration _washDuration = Duration(milliseconds: 750);
  String musicPathChoice = "";

  late CustomTimerController controllerTimer = CustomTimerController(
    vsync: this,
    begin: Duration(minutes: 3),
    end: Duration(),
    initialState: CustomTimerState.reset,
    interval: CustomTimerInterval.seconds,
  );
  bool get _isTimerActive =>
      controllerTimer.state.value != CustomTimerState.reset &&
      controllerTimer.state.value != CustomTimerState.finished;
  late AnimationController controllerAnimation;

  late Animation<Offset> _animation;

  String musicName = "";

  MusicSchema? selectedMusic;

  final List<MusicSchema> musicList = MusicList.getDefaultCards();

  Future<void> pickMusic() async {
    try {
      FilePickerResult? result;
      print("🎶 Déput de pickMusique");
      if (Platform.isIOS) {
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['mp3', 'm4a', 'wav', 'aac'],
        );
      } else if (Platform.isAndroid) {
        result = await FilePicker.platform.pickFiles(type: FileType.audio);
      }

      if (result == null || result.files.isEmpty) return;
      final PlatformFile file = result.files.single;

      final allowedExtensions = {'mp3', 'm4a', 'wav', 'aac'};
      final fileExtension = file.extension?.toLowerCase() ?? '';

      if (!allowedExtensions.contains(fileExtension)) {
        // ❌ Format non supporté
        if (Platform.isAndroid) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                 AppLocalizations.of(context)!.formatErrorMusic,
              ),
              duration: Duration(seconds: 3),
            ),
          );
        }
        return; // On arrête ici
      }
      String? sourcePath = file.path;
      if (sourcePath == null) {
        if (Platform.isAndroid) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                 AppLocalizations.of(context)!.noAccessFichier,
              ),
              duration: Duration(seconds: 3),
            ),
          );
        }
        return;
      }

      if (result.files.single.path != null) {
        String sourcePath = result.files.single.path!;

        try {
          final directory = await getApplicationDocumentsDirectory();
          final fileName = result.files.single.name;
          final permanentPath = '${directory.path}/$fileName';

          final File sourceFile = File(sourcePath);

          if (await sourceFile.exists()) {
            await sourceFile.copy(permanentPath);
            setState(() {
              musicPathChoice = permanentPath;
              musicName = fileName;
            });
          }
        } catch (e) {
          if (kDebugMode) {
            print('⚠️ Erreur copie fichier: $e');
          }

          if (Platform.isIOS) {
            setState(() {
              musicPathChoice = sourcePath;
            });
          } else {
            // ✅ Informer l'utilisateur sur Android
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.importImpossible),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erreur générale pickMusic: $e');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.error),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    controllerAnimation = AnimationController(
      duration: _washDuration,
      vsync: this,
    );

    _animation =
        Tween<Offset>(
          begin: const Offset(-0.3, 0),
          end: const Offset(-0.1, 0), //
        ).animate(
          CurvedAnimation(parent: controllerAnimation, curve: Curves.linear),
        );
    controllerTimer.addListener(() {
      if (controllerTimer.state.value == CustomTimerState.finished) {
        setState(() {
          controllerAnimation.stop();
        });
        final audioProvider = Provider.of<SoundProvider>(
          context,
          listen: false,
        );
        audioProvider.stopSound();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_audioProvider.stopSound());
    controllerTimer.dispose();
    controllerAnimation.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _audioProvider.stopSound();
    }
  }

  @override
  Widget build(BuildContext context) {
    _audioProvider = Provider.of<SoundProvider>(context, listen: false);
    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        await _audioProvider.stopSound();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextDegrade(title:  AppLocalizations.of(context)!.aideDents, choicetype: 'accueil'),
          leading: IconButton(
            onPressed: () async {
              final audioProvider = Provider.of<SoundProvider>(
                context,
                listen: false,
              );
              await audioProvider.stopSound();
              Navigator.pop(context);
            },
            icon: Icon(Icons.home),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Consumer2<SoundProvider, ScoreProvider>(
            builder: (context, audioProvider, scoreP, child) {
              if (!audioProvider.isReady) {
                return LoaderWidget();
              }
              return Center(
                child: Column(
                  spacing: 10,

                  children: [
                    CustomTimer(
                      controller: controllerTimer,

                      builder: (state, time) {
                        return CustomText.center(
                          "${time.minutes}:${time.seconds}",
                          Theme.of(context).textTheme.headlineLarge,
                        );
                      },
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15),
                      width: 300,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          controllerTimer.start();
                          _playCurrentMusic();
                          setState(() {
                            controllerAnimation.repeat(reverse: true);
                          });
                        },
                        child: Text("Start"),
                      ),
                    ),

                    if (_isTimerActive)
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            width: 300,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                controllerTimer.pause();
                                controllerAnimation.stop();
                                audioProvider.pauseSound();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.pauseAll,
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 15, bottom: 15),
                            width: 300,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                controllerTimer.pause();

                                controllerAnimation.stop();
                                audioProvider.pauseSound();
                                scoreP.incrementToothScore();
                                Navigator.pop(context);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.finValidation,
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () {
                                final audioProvider =
                                    Provider.of<SoundProvider>(
                                      context,
                                      listen: false,
                                    );
                                if (audioProvider.isPlaying) {
                                  audioProvider.pauseSound();
                                } else if (selectedMusic?.musicPath != null) {
                                  _playCurrentMusic();
                                }
                              },
                              child: Text(
                                audioProvider.isPlaying
                                    ? '⏸️ Pause'
                                    : '▶️ Play Musique',
                              ),
                            ),
                          ),
                        ],
                      ),

                    SizedBox(
                      height: 50,
                      child: DropdownButton<MusicSchema>(
                        value: selectedMusic,
                        hint: CustomText.center(
                           AppLocalizations.of(context)!.selectMusique,
                          Theme.of(context).textTheme.headlineSmall,
                        ),
                        items: musicList.map<DropdownMenuItem<MusicSchema>>((
                          MusicSchema music,
                        ) {
                          return DropdownMenuItem<MusicSchema>(
                            value: music,
                            child: CustomText.center(
                              music.musicTitle,
                              Theme.of(context).textTheme.headlineSmall,
                            ),
                          );
                        }).toList(),
                        onTap: () {
                          if (Platform.isIOS) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                   AppLocalizations.of(context)!.iosErrorImport,
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                        },
                        onChanged: (MusicSchema? newValue) {
                          print(
                            "🔍 onChanged appelé, newValue = ${newValue?.musicTitle}",
                          );
                          print("🔊 _isTimerActive ❌ = $_isTimerActive");

                          if (newValue == null) return;

                          if (newValue.musicTitle.toLowerCase() ==
                              "importation") {
                            setState(() {
                              selectedMusic = null;
                            });
                            pickMusic();
                            return;
                          }

                          final audioProvider = Provider.of<SoundProvider>(
                            context,
                            listen: false,
                          );
                          // print("🎵 audioProvider récupéré via Provider.of");

                          if (audioProvider.isPlaying) {
                            // print("🚀 Lecture demandée");
                            audioProvider.playSound(
                              newValue.musicPath,
                              "appli",
                            );
                          }

                          setState(() {
                            selectedMusic = newValue;
                          });
                        },
                      ),
                    ),

                    if (musicName.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            CustomText.center(
                              AppLocalizations.of(context)!.musiceEcoute,
                              Theme.of(context).textTheme.headlineSmall,
                            ),
                            CustomText.center(
                              musicName,
                              Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Stack(
                        alignment: AlignmentDirectional.center,

                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: ImageSet(sizewidth: 200, 0),
                          ),

                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return FractionalTranslation(
                                translation: _animation.value,
                                child: child,
                              );
                            },
                            child: Image.asset('assets/images/brosseadent.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _playCurrentMusic() {
    final audioProvider = Provider.of<SoundProvider>(context, listen: false);
    if (musicPathChoice.isNotEmpty) {
      audioProvider.playSound(musicPathChoice, "interne");
    } else if (selectedMusic != null) {
      audioProvider.playSound(selectedMusic!.musicPath, "appli");
    }
  }
}
