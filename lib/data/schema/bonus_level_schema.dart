class BonusLevel {
  final int declancheLevel;
  final String gradeName;
  final String description;

  BonusLevel({
    required this.declancheLevel,
    required this.gradeName,
    required this.description,
  });

  factory BonusLevel.fromCsv(List<dynamic> row) {
    return BonusLevel(
      declancheLevel: int.parse(row[0].toString()), 
      gradeName: row[1].toString(), 
      description: row[2].toString(), 
    );
  }
}
