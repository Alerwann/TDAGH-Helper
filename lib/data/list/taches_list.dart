import 'package:tdahelpe/data/schema/taches_shema.dart';

class TachesList {

  static final List<TachesSchema> _defaultTaches = [
    TachesSchema(tacheName: 'Vaisselle', tacheDuration: TacheDuration.court),
    TachesSchema(
      tacheName: 'Nettoyer la douche/ baignoire',
      tacheDuration: TacheDuration.moyen,
    ),
    TachesSchema(
      tacheName: 'Faire la poussière dans une pièce',
      tacheDuration: TacheDuration.tresLong,
    ),
    TachesSchema(
      tacheName: 'Préparer une liste de course',
      tacheDuration: TacheDuration.moyen,
    ),
    TachesSchema(
      tacheName: 'Faire ses comptes',
      tacheDuration: TacheDuration.long,
    ),
     TachesSchema(
      tacheName: 'Nettoyer les WC',
      tacheDuration: TacheDuration.moyen,
    ),
     TachesSchema(
      tacheName: 'Sortir les poubelles',
      tacheDuration: TacheDuration.court,
    ),

  ];

  static List<TachesSchema> getDefaultCards() {
    return List.from(_defaultTaches);
  }
}
