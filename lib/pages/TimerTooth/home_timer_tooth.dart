import 'package:flutter/material.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter_application_1/audio/audio_controller.dart';
import 'package:flutter_application_1/data/music_list.dart';
import 'package:flutter_application_1/data/schema/music_schema.dart';

import 'package:flutter_application_1/providers/sound_provider.dart';
import 'package:flutter_application_1/widget/imageSet.dart';
import 'package:provider/provider.dart';

class HomeTimertooth extends StatefulWidget {
  const HomeTimertooth({super.key});

  @override
  State<HomeTimertooth> createState() => _HomeTimertoothState();
}

class _HomeTimertoothState extends State<HomeTimertooth>
    with TickerProviderStateMixin {
  final Duration _washDuration = Duration(seconds: 1);

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

  MusicSchema? selectedMusic;
  final List<MusicSchema> musicList = MusicList.getDefaultCards();

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
          begin: const Offset(-0.3, 0), // Commence hors écran à gauche
          end: const Offset(-0.1, 0), // Termine hors écran à droite
        ).animate(
          CurvedAnimation(parent: controllerAnimation, curve: Curves.linear),
        );
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
      appBar: AppBar(),
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
                        if (selectedMusic != null) {
                          soundController.playSound(selectedMusic!.musicPath);
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
                        soundController.pauseMusic();
                      },
                      child: Text('Stop'),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 40),
                DropdownButton<MusicSchema>(
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
                    setState(() {
                      selectedMusic = newValue;
                    });
                    if (_timerIsActive == true) {
                      soundController.playSound(selectedMusic!.musicPath);
                    }
                  },
                ),
                Center(
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
