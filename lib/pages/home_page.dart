import 'package:flutter/material.dart';
import 'package:tdahelpe/data/list/activity_list.dart';
import 'package:tdahelpe/data/schema/activity_card_schema.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/providers/sound_provider.dart';
import 'package:provider/provider.dart';

class HomeGlobalPage extends StatefulWidget {
  const HomeGlobalPage({super.key});

  @override
  State<HomeGlobalPage> createState() => _HomeGlobalPageState();
}

class _HomeGlobalPageState extends State<HomeGlobalPage> {
  late List<ActivityCard> activityCard = ActivityList.getDefaultCards();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Consumer<ProfilProvider>(
          builder: (context, profil, child) {
            return Center(
              child: Text(
                "Bienvenue ${profil.pseudo}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.amber,
                ),
              ),
            );
          },
        ),
      ),
      body: Consumer<SoundProvider>(
        builder: (context, audioProvider, child) {
          // Afficher un loader si l'audio n'est pas prêt
          if (audioProvider.isInitializing) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Initialisation de l\'audio...'),
                ],
              ),
            );
          }

          if (!audioProvider.isReady) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 50),
                  Text('Erreur d\'initialisation audio'),
                ],
              ),
            );
          }

          return Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 400,
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: activityCard[index].backColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                activityCard[index].destination,
                          ),
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              activityCard[index].imagePath,
                              height: 130,
                              width: 130,
                            ),
                            SizedBox(height: 10),

                            ShaderMask(
                              shaderCallback: (bounds) {
                                return LinearGradient(
                                  colors: [
                                    activityCard[index].firstColor,
                                    activityCard[index].secondColor,
                                  ],
                                ).createShader(
                                  Rect.fromLTWH(
                                    0,
                                    0,
                                    bounds.width,
                                    bounds.height,
                                  ),
                                );
                              },
                              child: Text(
                                activityCard[index].activityName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
