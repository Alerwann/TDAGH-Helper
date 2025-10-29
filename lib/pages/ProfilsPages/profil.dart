// Page d'accueil des paramètres
// Permet l'accès à la modification du profil, des horaires et l'autorisation des notifications
// Donne accès à "A propos"

import 'dart:io';
import 'package:tdahelpe/pages/ProfilsPages/modif_horaire.dart';
import 'package:tdahelpe/pages/ProfilsPages/profil_parametre.dart';
import 'package:tdahelpe/pages/home/about_page.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/services/notifications/android_notification_handler.dart';
import 'package:tdahelpe/services/notifications/ios_notification_handler.dart';
import 'package:tdahelpe/utils/device_utils.dart';
import 'package:tdahelpe/widget/utils/buton_theme.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';
import 'package:tdahelpe/widget/utils/imageSet.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool _showAndroidMessage = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    print("👾 load data du paramètre");
    _showAndroidMessage = await DeviceUtils.isBatteryOptimizationNeeded();
    print("👾 showAndroidmessage : $_showAndroidMessage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        "Gestion du profil",
        context,
        "parametre",
        false,
        Icon(Icons.home),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Consumer<ProfilProvider>(
          builder: (context, profil, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: ImageSet(sizewidth: 150, 0),
                  ),
                  CustomText.center(
                    profil.pseudo,
                    Theme.of(context).textTheme.headlineMedium,
                  ),
                  ButonTheme.boutonOfParametre(
                    "Gestion du profil",
                    HugeIconsStroke.manWoman,
                    ProfilParametreConfig(),
                    context,
                  ),

                  ButonTheme.boutonOfParametre(
                    'Choix des heures',
                    HugeIconsStroke.hourglass,
                    ModifHoraire(),
                    context,
                  ),

                  SizedBox(
                    width: 300,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (Platform.isAndroid) {
                          if (_showAndroidMessage) {
                            DeviceUtils.dialogAndroidOther(context);
                          } else {
                            AndroidNotificationHandler.openSettingsAndroid();
                          }
                        } else if (Platform.isIOS) {
                          IosNotificationHandler.openSettingsIos();
                        }
                      },
                      icon: Icon(
                        Icons.notifications_active,
                        color: Color.fromARGB(225, 1, 112, 81),
                      ),
                      label: Text(
                        "Modifier les notifications",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  ButonTheme.boutonOfParametre(
                    "À propos",
                    Icons.app_shortcut_rounded,
                    AboutPage(),
                    context,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
