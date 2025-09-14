import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/activity_list.dart';
import 'package:flutter_application_1/data/schema/activity_card_schema.dart';
import 'package:flutter_application_1/providers/profil_provider.dart';
import 'package:flutter_application_1/providers/sound_provider.dart';
import 'package:gradient_txt/gradient_text.dart';
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
        title: Consumer<ProfilProvider>(
          builder: (context, profil, child) {
            return Text("Bienvenu ${profil.pseudo}");
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

          // Afficher une erreur si l'audio n'a pas pu s'initialiser
          if (!audioProvider.isReady) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 50),
                  Text('Erreur d\'initialisation audio'),
                  // ElevatedButton(
                  //   onPressed: () => audioProvider.initialize(),
                  //   child: Text('Réessayer'),
                  // ),
                ],
              ),
            );
          }

          // Interface normale une fois l'audio prêt
          return Center(
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => activityCard[index].destination,
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
                          GradientText(
                            text: activityCard[index].activityName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                activityCard[index].firstColor,
                                activityCard[index].secondColor,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
