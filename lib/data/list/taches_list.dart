import 'package:flutter_application_1/data/schema/taches_shema.dart';

class TachesList {
  // Liste par défaut (immuable)
  static final List<TachesSchema> _defaultTaches = [
    TachesSchema(tacheName: 'Vaisselle', tacheDuration: TacheDuration.court),
    TachesSchema(
      tacheName: 'Poussière dans la chambre',
      tacheDuration: TacheDuration.moyen,
    ),
    TachesSchema(
      tacheName: 'Poussière dans la salle',
      tacheDuration: TacheDuration.tresLong,
    ),
    TachesSchema(
      tacheName: 'Trier le courrier',
      tacheDuration: TacheDuration.moyen,
    ),
    TachesSchema(
      tacheName: 'Vérifier et régler les factures en retard',
      tacheDuration: TacheDuration.long,
    ),
  ];

  static List<TachesSchema> getDefaultCards() {
    return List.from(_defaultTaches);
  }
}
