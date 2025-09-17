class TachesSchema {
  final String tacheName;
  final TacheDuration tacheDuration;

  TachesSchema({required this.tacheName, required this.tacheDuration});

  Map<String, dynamic> toJson() {
    return {
      'tacheName': tacheName,
      'tacheDuration': tacheDuration.name, // .name donne le string de l'enum
    };
  }

  // Créer depuis JSON
  factory TachesSchema.fromJson(Map<String, dynamic> json) {
    return TachesSchema(
      tacheName: json['tacheName'],
      tacheDuration: TacheDuration.values.byName(json['tacheDuration']),
    );
  }
}

enum TacheDuration { court, moyen, long, tresLong }
