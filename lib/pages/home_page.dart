// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/core/navigation/app_navigator.dart';
import 'package:tdahelpe/data/list/activity_list.dart';
import 'package:tdahelpe/data/schema/activity_card_schema.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/providers/sound_provider.dart';
import 'package:provider/provider.dart';
// import 'package:tdahelpe/utils/device_utils.dart';
import 'package:tdahelpe/utils/permission_banner.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';
import 'package:tdahelpe/widget/utils/loader_widget.dart';

class HomeGlobalPage extends StatefulWidget {
  const HomeGlobalPage({super.key});

  @override
  State<HomeGlobalPage> createState() => _HomeGlobalPageState();
}

class _HomeGlobalPageState extends State<HomeGlobalPage> {

  late List<ActivityCard> activityCard = ActivityList.getDefaultCards();

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfilProvider, SoundProvider>(
      builder: (context, profil, audioProvider, child) {
        return Scaffold(
          appBar: CustomHeightApBcar.customApp(
            "Bienvenue ${profil.pseudo}",
            context,
            "accueil",
            false,
            Icon(Icons.home),
          ),

          body: Column(
            children: [
              PermissionBanner(),
              Expanded(
                child: Consumer<SoundProvider>(
                  builder: (context, audioProvider, child) {
                    if (audioProvider.isInitializing) {
                      return LoaderWidget();
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
                        child: Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
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
                                        backgroundColor:
                                            activityCard[index].backColor,
                                      ),
                                      onPressed: () {
                                        AppNavigator.push(
                                          context,
                                          activityCard[index].destination,
                                        );
                                      },

                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              activityCard[index].imagePath,
                                              height: 130,
                                              width: 130,
                                            ),
                                            SizedBox(height: 10),
                                            ShaderMask(
                                              shaderCallback: (bounds) {
                                                final gradient = LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                      255,
                                                      167,
                                                      30,
                                                      241,
                                                    ),
                                                    const Color.fromARGB(
                                                      255,
                                                      53,
                                                      0,
                                                      84,
                                                    ),
                                                    Color.fromARGB(
                                                      255,
                                                      177,
                                                      23,
                                                      228,
                                                    ),
                                                  ],
                                                );
                                                return gradient.createShader(
                                                  Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    bounds.width,
                                                    bounds.height,
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                activityCard[index]
                                                    .activityName,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                                maxLines: null,
                                                textAlign: TextAlign.center,
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
