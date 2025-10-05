import 'dart:io' show Platform, File;
import 'package:tdahelpe/data/list/music_list.dart';
import 'package:tdahelpe/data/schema/music_schema.dart';
import 'package:tdahelpe/main.dart';
import 'package:tdahelpe/providers/sound_provider.dart';
import 'package:tdahelpe/services/audio_controller.dart';
import 'package:tdahelpe/widget/imageSet.dart';
import 'package:flutter/material.dart';
import 'package:custom_timer/custom_timer.dart';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class HomeTimertooth extends StatefulWidget {
  const HomeTimertooth({super.key});

  @override
  State<HomeTimertooth> createState() => _HomeTimertoothState();
}

class _HomeTimertoothState extends State<HomeTimertooth>
    with TickerProviderStateMixin {
  final Duration _washDuration = Duration(milliseconds: 750);
  String musicPathChoice = "";
  final AudioController soundController = AudioController();
  // ignore: unused_field
  bool _timerIsActive = false;
  late CustomTimerController controllerTimer = CustomTimerController(
    vsync: this,
    begin: Duration(minutes: 3),
    end: Duration(),
    initialState: CustomTimerState.reset,
    interval: CustomTimerInterval.seconds,
  );

  late AnimationController controllerAnimation;

  late Animation<Offset> _animation;
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

  String musicName = "";

  MusicSchema? selectedMusic;

  final List<MusicSchema> musicList = MusicList.getDefaultCards();

  Future<void> pickMusic() async {
    FilePickerResult? result;

    // Adapte le type de fichier selon la plateforme
    if (Platform.isIOS) {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'm4a', 'wav', 'aac'],
      );
    } else {
      result = await FilePicker.platform.pickFiles(type: FileType.audio);
    }

    if (result != null && result.files.single.path != null) {
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
        } else {
          // Fallback pour iOS : essaie de jouer directement
          if (Platform.isIOS) {
            setState(() {
              musicPathChoice = sourcePath;
              musicName = fileName;
            });
          }
        }
      } catch (e) {
        // Sur iOS, si la copie échoue, on tente de jouer directement
        if (Platform.isIOS) {
          setState(() {
            musicPathChoice = sourcePath;
          });
        }
      }
    }

    if (_timerIsActive && musicPathChoice.isNotEmpty) {
      final audioProvider = Provider.of<SoundProvider>(context, listen: false);
      audioProvider.playSound(musicPathChoice, "interne");
    }
  }

  @override
  void initState() {
    super.initState();

    soundController.initialize();

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
      if (controllerTimer.state.value == CustomTimerState.finished &&
          _timerIsActive) {
        setState(() {
          _timerIsActive = false;
          controllerAnimation.stop();
        });
        soundController.stopMusic();
      }
    });
  }

  @override
  void dispose() async {
    soundController.stopMusic().then((_) {
      soundController.dispose;
    });
    controllerTimer.dispose();
    controllerAnimation.dispose();

    super.dispose();
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
          child: Text("Aides Les Dents", style: textStyle),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
          icon: Icon(
            Icons.home,
            color: const Color.fromARGB(255, 230, 177, 2),
            size: 45,
          ),
        ),
      ),
      body: Consumer<SoundProvider>(
        builder: (context, audioProvider, child) {
          // Vérifier si l'audio est prêt
          if (!audioProvider.isReady) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Audio en cours d\'initialisation...'),
                ],
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTimer(
                  controller: controllerTimer,

                  builder: (state, time) {
                    return Text(
                      "${time.minutes}:${time.seconds}",
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Metamorphous',
                      ),
                    );
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controllerTimer.start();
                        _timerIsActive = true;

                        if (musicPathChoice.isNotEmpty) {
                          audioProvider.playSound(musicPathChoice, "interne");
                        } else if (selectedMusic != null) {
                          audioProvider.playSound(
                            selectedMusic!.musicPath,
                            "appli",
                          );
                        } else {}

                        setState(() {
                          controllerAnimation.repeat(reverse: true);
                        });
                      },
                      child: Text('Start'),
                    ),
                    SizedBox(width: 20),

                    ElevatedButton(
                      onPressed: () {
                        controllerTimer.pause();
                        _timerIsActive = false;
                        controllerAnimation.stop();
                        audioProvider.pauseSound();
                      },
                      child: Text('Stop'),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(
                  height: 50,
                  child: DropdownButton<MusicSchema>(
                    value: selectedMusic,
                    hint: const Text('Sélectionner une musique'),
                    items: musicList.map<DropdownMenuItem<MusicSchema>>((
                      MusicSchema music,
                    ) {
                      return DropdownMenuItem<MusicSchema>(
                        value: music,
                        child: Text(music.musicTitle),
                      );
                    }).toList(),
                    onTap: () {
                      if (Platform.isIOS) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Importation de son uniquement depuis Fichiers, iCloud ou Téléchargements',
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    onChanged: (MusicSchema? newValue) {
                      if (newValue!.musicTitle == "Importation") {
                        pickMusic();
                      } else {
                        musicPathChoice = "";
                        musicName = "";
                      }

                      setState(() {
                        selectedMusic = newValue;
                      });
                      if (_timerIsActive == true) {
                        if (musicPathChoice != "") {
                          audioProvider.playSound(musicPathChoice, "interne");
                        } else {
                          audioProvider.playSound(newValue.musicPath, "appli");
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                if (musicName != "")
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [Text("Musique à l'écoute :"), Text(musicName)],
                    ),
                  ),
                SizedBox(
                  height: 300,
                  child: Stack(
                    alignment: AlignmentDirectional.center,

                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: ImageSet(sizewidth: 600, 0),
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
    );
  }
}
