class TachesSchema {
  final String tacheName;
  final TacheDuration tacheDuration;
  final bool isCustom ;

  TachesSchema({required this.tacheName, required this.tacheDuration,required this.isCustom});

  Map<String, dynamic> toJson() {
    return {
      'tacheName': tacheName,
      'tacheDuration': tacheDuration.name,
      'isCustom': isCustom,
    };
  }

  // Créer depuis JSON
  factory TachesSchema.fromJson(Map<String, dynamic> json) {
    return TachesSchema(
      tacheName: json['tacheName'],
      tacheDuration: TacheDuration.values.byName(json['tacheDuration']),
      isCustom: json['isCustom'] ?? false,
    );
  }
}

enum TacheDuration { court, moyen, long, tresLong }
