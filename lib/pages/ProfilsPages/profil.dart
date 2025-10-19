import 'package:tdahelpe/pages/ProfilsPages/heures_parametre.dart';
import 'package:tdahelpe/pages/ProfilsPages/profil_parametre.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appcar.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightAppcar.customApp("Gestion du profil", context, "parametre", false),

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
                  SizedBox(
                    width: 300,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilParametreConfig(),
                          ),
                        );
                      },
                      icon: Icon(
                        HugeIconsStroke.manWoman,
                        size: 20,
                        color: Color.fromARGB(225, 1, 112, 81),
                      ),

                      label: Text(
                        'Gère ton profil',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 300,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HeureParametreConfig(),
                          ),
                        );
                      },

                      icon: Icon(
                        HugeIconsStroke.hourglass,
                        size: 20,
                        color: Color.fromARGB(225, 1, 112, 81),
                      ),

                      label: Text(
                        'Choix des heures',
                        textAlign: TextAlign.center,
                      ),
                    ),
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
