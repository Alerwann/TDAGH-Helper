import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/taches_provider.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';

class Quetesfinales extends StatefulWidget {
  const Quetesfinales({super.key});

  @override
  State<Quetesfinales> createState() => _QuetesfinalesState();
}

class _QuetesfinalesState extends State<Quetesfinales> {
  int currentStep = 0;
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
  List<bool> isChecked = [];

  @override
  void initState() {
    super.initState();
    // Initialise après que le widget soit créé
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tacheProvider = Provider.of<TachesProvider>(context, listen: false);
      setState(() {
        isChecked = List<bool>.generate(
          tacheProvider.choixTaches.length,
          (index) => false,
        );
      });
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
            "Liste d'activités du jour",
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Center(
        child: Consumer<TachesProvider>(
          builder: (context, tacheP, child) {
            if (isChecked.length != tacheP.choixTaches.length) {
              isChecked = List<bool>.generate(
                tacheP.choixTaches.length,
                (index) => false,
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Liste finale:",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 300,
                  child: LinearProgressBar(
                    maxSteps: tacheP.choixTaches.length,
                    progressType: LinearProgressBar.progressTypeLinear,
                    currentStep: currentStep,
                    progressColor: const Color.fromARGB(255, 255, 1, 242),
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 255, 1, 242),
                    ),
                    semanticsLabel: "Label",
                    semanticsValue: "Value",
                    minHeight: 30,
                    borderRadius: BorderRadius.circular(10), //  NEW
                  ),
                ),

                for (int i = 0; i < tacheP.choixTaches.length; i++)
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked[i],
                        onChanged: (bool? value) {
                          print(isChecked[i]);
                          setState(() {
                            isChecked[i] = value!;
                            if (isChecked[i] == true) {
                              currentStep += 1;
                            } else {
                              currentStep -= 1;
                            }

                            print(isChecked[i]);
                          });
                        },
                      ),
                      Text(tacheP.choixTaches[i]),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
