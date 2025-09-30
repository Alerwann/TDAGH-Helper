import 'package:flutter_application_1/data/list/music_list.dart';
import 'package:flutter_application_1/data/schema/music_schema.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/providers/sound_provider.dart';
import 'package:flutter_application_1/services/audio_controller.dart';
import 'package:flutter_application_1/widget/imageSet.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:custom_timer/custom_timer.dart';

import 'package:file_picker/file_picker.dart';

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

  String musicName = "";

  MusicSchema? selectedMusic;

  final List<MusicSchema> musicList = MusicList.getDefaultCards();

  Future<void> pickMusic() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        musicPathChoice = result.files.single.path!;
        musicName = path.basename(musicPathChoice);
      });
    }

    if (_timerIsActive) {
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
            size: 35,
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

                        print("🔍 musicPathChoice: '$musicPathChoice'");
                        print("🔍 selectedMusic: $selectedMusic");

                        if (musicPathChoice.isNotEmpty) {
                          print("➡️ Lecture fichier interne");
                          audioProvider.playSound(musicPathChoice, "interne");
                        } else if (selectedMusic != null) {
                          print(
                            "➡️ Lecture fichier app: ${selectedMusic!.musicPath}",
                          );
                          audioProvider.playSound(
                            selectedMusic!.musicPath,
                            "appli",
                          );
                        } else {
                          print("❌ Aucune musique sélectionnée");
                        }

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
