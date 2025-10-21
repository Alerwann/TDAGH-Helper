import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class HoraireChamps extends StatelessWidget {
  final String moment;
  final TextEditingController momentController;
  const HoraireChamps({super.key, required this.moment, required this.momentController});

  @override
  Widget build(BuildContext context) {
    return Consumer<HeureProfilProvider>(builder: (context, heureP, child) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        spacing: 10,
        children: [
          
          CustomText.center(
            'Heure du $moment',
            Theme.of(context).textTheme.headlineMedium,
          ),
          TextFormField(
            controller: momentController,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: "Heure",
              prefixIcon: Icon(Icons.timer),
              labelText: 'Horaire désiré',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un nombre';
              }
              if (int.tryParse(value) == null) {
                return 'Veuillez entrer un nombre valide';
              }
              if (int.tryParse(value)! > 24) {
                return "Heure invalide, elle doit être inférieur à 24";
              }
              if (int.tryParse(value)! < 0) {
                return "Heure invalide, elle doit être positive";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
    );
  }
}














