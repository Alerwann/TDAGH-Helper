import 'package:tdahelpe/data/schema/taches_shema.dart';

class TachesList {
  static final List<TachesSchema> _defaultTaches = [
    TachesSchema(
      tacheName: 'Vaisselle',
      tacheDuration: TacheDuration.court,
      isCustom: false,
    ),
    TachesSchema(
      tacheName: 'faisLaVaisselle',
      tacheDuration: TacheDuration.moyen,
      isCustom: false,
    ),
    TachesSchema(
      tacheName: 'poussiere',
      tacheDuration: TacheDuration.tresLong,
      isCustom: false,
    ),
    TachesSchema(
      tacheName: 'listCourse',
      tacheDuration: TacheDuration.moyen,
      isCustom: false,
    ),
    TachesSchema(
      tacheName: 'comptes',
      tacheDuration: TacheDuration.long,
      isCustom: false,
    ),
    TachesSchema(
      tacheName: 'laveWc',
      tacheDuration: TacheDuration.moyen,
      isCustom: false,
    ),
    TachesSchema(
      tacheName: 'poubelles',
      tacheDuration: TacheDuration.court,
      isCustom: false,
    ),
  ];

  static List<TachesSchema> getDefaultCards() {
    return List.from(_defaultTaches);
  }
}
