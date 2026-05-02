import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/data/list/langues_list.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';

class ModifLangue extends StatefulWidget {
  const ModifLangue({super.key});

  @override
  State<ModifLangue> createState() => _ModifLangueState();
}

class _ModifLangueState extends State<ModifLangue> {
  String? selectLanguage = 'fr';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeightApBcar.customApp(
        AppLocalizations.of(context)!.langue,
        context,
        "parametre",
        true,
        Icon(Icons.arrow_back_rounded),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Consumer<ProfilProvider>(
            builder: (context, profil, child) {
              print("⚠️.  $selectLanguage");
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RadioGroup<String>(
                      groupValue: selectLanguage,
                      onChanged: (String? value) {
                        if (value != null) {
                          print('⚠️ $selectLanguage');

                          setState(() {
                            selectLanguage = value;
                          });
                        }
                      },
                      child: Column(
                        children: [
                          ...availableLanguages.map((langs) {
                            print("🧡 code : ${langs['code']}");
                            print("🧡 nom : ${langs['name']}");
                            print("❤️‍🔥 ${langs['code'] == selectLanguage}");
                            return RadioListTile<String>(
                              value: langs['code']!,
                              title: Text(langs['name']!),
                            );
                          }),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (selectLanguage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!.dureeAct,
                              ),
                            ),
                          );
                          return;
                        }

                       final validSave= await profil.setLanguage(selectLanguage!);
                        if(validSave){
                                  ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!.succesLangue,
                              ),
                            ),
                          );
                        }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!.erreurLangue,
                              ),
                            ),
                          );
                        }
                
                      },
                      child: Text(AppLocalizations.of(context)!.valider),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
