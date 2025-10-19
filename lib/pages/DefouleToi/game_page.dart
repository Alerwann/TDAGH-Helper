import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/pages/DefouleToi/finish_defoule.dart';

import 'package:tdahelpe/providers/defoule_provider.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double _x = 100;
  double _y = 100;
  double _xTap = 0;
  double _yTap = 0;
  int _score = 0;
  Size _containerSize = Size.zero;
  final double _radius = 30;
  bool _compteurActive = false;

  final CountdownController _controller = CountdownController();

  void _randomPoint() {
    if (_containerSize.width > 2 * _radius &&
        _containerSize.height > 2 * _radius) {
      _x =
          _radius +
          Random().nextDouble() * (_containerSize.width - 2 * _radius);
      _y =
          _radius +
          Random().nextDouble() * (_containerSize.height - 2 * _radius);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DefouleProvider>(
        builder: (context, defouleP, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Container(height: 80),
                Countdown(
                  controller: _controller,
                  seconds: defouleP.timerDuration,
                  build: (BuildContext context, double time) =>
                      CustomText.center(
                        "Timer : ${time.toString()}",
                        Theme.of(context).textTheme.titleMedium,
                      ),
                  interval: Duration(milliseconds: 100),
                  onFinished: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinishDefoule(score: _score),
                      ),
                    );
                  },
                ),
                !_compteurActive
                    ? ElevatedButton(
                        onPressed: () {
                 
                          _controller.restart();
                          setState(() {
                            _compteurActive = true;
                            _score = 0;
                          });
                        },
                        child: Text("Début"),
                      )
                    : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 20,

                          children: [
                            Text(
                              "Ton score :$_score",
                              style: TextStyle(fontSize: 40),
                            ),

                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  _containerSize = Size(
                                    constraints.maxWidth,
                                    constraints.maxHeight,
                                  );

                                  return GestureDetector(
                                    onTapDown: (TapDownDetails details) {
                                      _xTap = details.localPosition.dx;
                                      _yTap = details.localPosition.dy;

                                      setState(() {
                                        if ((_x - _radius <= _xTap &&
                                                _xTap <= _x + _radius) &&
                                            (_y - _radius <= _yTap &&
                                                _yTap <= _y + _radius)) {
                                          _score += 1;
                                        }
                                        _randomPoint();
                                      });
                                    },
                                    child: CustomPaint(
                                      painter: MyGamePainter(_x, _y),
                                      size: Size.infinite,
                                    ),
                                  );
                                },
                              ),
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

class MyGamePainter extends CustomPainter {
  final double x;
  final double y;

  MyGamePainter(this.x, this.y);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(x, y), 30, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
