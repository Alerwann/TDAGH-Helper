import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:tdahelpe/providers/heures_profil_provider.dart';
import 'package:tdahelpe/widget/utils/custom_text.dart';

class HoraireChamps extends StatelessWidget {
  final String moment;
  final TextEditingController momentController;
  const HoraireChamps({
    super.key,
    required this.moment,
    required this.momentController,
  });

  @override
  Widget build(BuildContext context) {
    String momentAff = "";

    if (moment == "reinit") {
      print("✅ je suis dans le if");
      momentAff = AppLocalizations.of(context)!.momentAff;
    } else {
      momentAff = AppLocalizations.of(context)!.momentRepas(moment);
    }

    return Consumer<HeureProfilProvider>(
      builder: (context, heureP, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            spacing: 10,
            children: [
              CustomText.center(
                momentAff,
                Theme.of(context).textTheme.headlineMedium,
              ),
              TextFormField(
                controller: momentController,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(
                    context,
                  )!.hour,
                  prefixIcon: Icon(Icons.timer),
                  labelText: AppLocalizations.of(
                    context,
                  )!.decidHour,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(
                      context,
                    )!.enterNumber;
                  }
                  if (int.tryParse(value) == null) {
                    return AppLocalizations.of(
                      context,
                    )!.errorTypeNumber;
                  }
                  if (int.tryParse(value)! > 24) {
                    return AppLocalizations.of(
                      context,
                    )!.errorHourToHeight;
                  }
                  if (int.tryParse(value)! < 0) {
                    return AppLocalizations.of(
                      context,
                    )!.errorHourNegative;
                  }
                  return null;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
