import 'package:tdahelpe/data/schema/bonus_level.dart';

class BonusLevelList {
  static final List<BonusLevel> _defaultCards = [
    BonusLevel(declancheLevel:1, gradeName: "Explorateur"),
    BonusLevel(declancheLevel: 5, gradeName: "Endurant"),
    BonusLevel(declancheLevel: 10, gradeName: "Obstiné"),
    BonusLevel(declancheLevel: 15, gradeName: "Têtu"),
    BonusLevel(declancheLevel: 20, gradeName: "Maitre de la routine"),
    BonusLevel(declancheLevel: 25, gradeName: "Seigneur des tâches"),
    BonusLevel(declancheLevel: 30, gradeName: "Roi de l'organisation"),
    BonusLevel(declancheLevel: 35, gradeName: "Dominateur des entraves"),
    BonusLevel(declancheLevel: 40, gradeName: "EN COURS DE CREATION")
  ];

  static List<BonusLevel> getDefaultCards() {
    return List.from(_defaultCards);
  }
}
