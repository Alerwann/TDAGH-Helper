import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/heures_profil_provider.dart';
import 'package:provider/provider.dart';

class HeureParametreConfig extends StatefulWidget {
  const HeureParametreConfig({super.key});

  @override
  State<HeureParametreConfig> createState() => _HeureParametreConfigState();
}

class _HeureParametreConfigState extends State<HeureParametreConfig> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 50,
                  color: Colors.black,
                  fontFamily: 'Metamorphous',
                ),
                child: AnimatedTextKit(
                  animatedTexts: [WavyAnimatedText('Horaires')],
                  isRepeatingAnimation: true,
                ),
              ),
              SizedBox(height: 20),
              _horairesModif('réveil', 'réveil'),
              _horairesModif('repas de midi', 'midi'),
              _horairesModif('repas du soir', 'soir'),
              _horairesModif('couché', 'couché'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Réinitialisation faite'),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                    FocusScope.of(context).requestFocus(FocusNode());
                    Provider.of<HeureProfilProvider>(
                      context,
                      listen: false,
                    ).resetAllHours();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: Text(
                  'Réinitialiser',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _horairesModif(String moment, String momentsend) {
    return Column(
      children: [
        Text(
          'Heure du $moment',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Consumer<HeureProfilProvider>(
                builder: (context, profil, child) {
                  int momentProfil = 12;
                  switch (moment) {
                    case 'réveil':
                      momentProfil = profil.reveilHours;
                      break;
                    case 'repas de midi':
                      momentProfil = profil.midiHours;
                      break;
                    case 'repas du soir':
                      momentProfil = profil.soirhours;
                      break;
                    case 'couché':
                      momentProfil = profil.coucheHours;
                      break;
                  }
                  return Center(
                    child: DropdownMenuFormField(
                      key: ValueKey('${moment}_$momentProfil'),
                      initialSelection: momentProfil,

                      label: Text('Heures'),
                      width: 200,
                      menuHeight: 200,
                      dropdownMenuEntries: List.generate(
                        24,
                        (hours) => DropdownMenuEntry(
                          value: hours,
                          label: hours.toString().padLeft(2, '0'),
                        ),
                      ),

                      onSelected: (hours) =>
                          profil.setHours(hours!, momentsend),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
