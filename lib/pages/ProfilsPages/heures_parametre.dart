import 'dart:io';

import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/services/notification_service.dart';

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

              // Les 4 menus déroulants
              _horairesModif('réveil', 'réveil'),
              _horairesModif('repas de midi', 'midi'),
              _horairesModif('repas du soir', 'soir'),
              _horairesModif('couché', 'couché'),

              SizedBox(height: 20),

              // NOUVEAU : Bouton pour valider et programmer les notifications
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Vérifier les permissions sur Android
                    if (Platform.isAndroid) {
                      bool hasPermission =
                          await NotificationService.checkPermissions();

                      if (!hasPermission) {
                        // Afficher le dialogue d'explication
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Permission requise'),
                            content: Text(
                              'Pour que les notifications fonctionnent, tu dois :\n\n'
                              '1. Autoriser les "Alarmes et rappels"\n'
                              '2. Désactiver l\'optimisation batterie\n'
                              '3. Activer le démarrage automatique\n\n'
                              'Clique sur "Ouvrir" pour accéder aux paramètres.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Annuler'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  NotificationService.openSettings();
                                },
                                child: Text('Ouvrir'),
                              ),
                            ],
                          ),
                        );
                        return; // Arrêter ici si pas de permission
                      }
                    }

                    // Si on a les permissions, programmer les notifications
                    final profil = Provider.of<HeureProfilProvider>(
                      context,
                      listen: false,
                    );

                    await NotificationService.scheduleAllNotifications(
                      reveilHour: profil.reveilHours,
                      midiHour: profil.midiHours,
                      soirHour: profil.soirhours,
                      coucheHour: profil.coucheHours,
                    );

                    // Message de confirmation
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          '✅ Notifications programmées avec succès !',
                        ),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );

                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  'Valider les horaires',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              SizedBox(height: 10),

              // Bouton réinitialiser (existant)
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

  // Ton widget _horairesModif reste INCHANGÉ
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
                      // ✅ VÉRIFIER ICI que la valeur a changé
                      onSelected: (hours) {
                        if (hours != null && hours != momentProfil) {
                          print(
                            '📝 Widget: changement détecté $momentProfil → $hours',
                          );
                          profil.setHours(hours, momentsend);
                        } else {
                          print('⏭️ Widget: même valeur ($hours), ignoré');
                        }
                      },
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
