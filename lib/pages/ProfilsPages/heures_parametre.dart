import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/utils/horaire_moment.dart';
import 'package:tdahelpe/widget/utils/custom_height_appbar.dart';

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
      appBar: CustomHeightApBcar.customApp(
        "Configuration des horaires",
        context,
        "parametre",
        true,
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                HoraireMoment.horairesModif('réveil', 'réveil', context),
                HoraireMoment.horairesModif('repas de midi', 'midi', context),
                HoraireMoment.horairesModif('repas du soir', 'soir', context),
                HoraireMoment.horairesModif('couché', 'couché', context),
                HoraireMoment.horairesModif(
                  'réinitialisation',
                  'reinit',
                  context,
                ),

                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
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
      ),
    );
  }
}
