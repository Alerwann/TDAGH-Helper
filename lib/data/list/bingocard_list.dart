import '../schema/bingo_card_schema.dart';

class BingoDataMorning {
  static final List<BingoCard> _defaultCards = [
    BingoCard(
      frontText: 'Faire ton lit',
      frontImagePath: 'assets/images/bingo_images/litdefait.png',
      backImagePath: 'assets/images/bingo_images/litfait.png',
      isFlipped: false
    ),
    BingoCard(
      frontText: 'Laver les dents',
      frontImagePath: 'assets/images/bingo_images/dentsalle.png',
      backImagePath: 'assets/images/bingo_images/dentpropre.png',
      isFlipped: false
    ),
    BingoCard(
      frontText: "Prendre le traitement",
      frontImagePath: 'assets/images/bingo_images/medocs.png',
      backImagePath: "assets/images/bingo_images/medocpris.png",
      isFlipped: false
    ),
    BingoCard(
      frontText: 'Douche',
      frontImagePath: "assets/images/bingo_images/douche.png",
      backImagePath: "assets/images/bingo_images/doucheprise.png",
      isFlipped: false
    ),
  ];

  static List<BingoCard> getDefaultCards() {
    return List.from(_defaultCards);
  }
}

class BingoDataMidi {
  static final List<BingoCard> _defaultCards = [
    BingoCard(
      frontText: 'Boire',
      frontImagePath: "assets/images/bingo_images/boire.png",
      backImagePath: "assets/images/bingo_images/bu.png",
      isFlipped: false
    ),
     BingoCard(
      frontText: "Prendre le traitement",
      frontImagePath: 'assets/images/bingo_images/medocs.png',
      backImagePath: "assets/images/bingo_images/medocpris.png",
      isFlipped: false
    ),
     BingoCard(
      frontText: "Manger",
      frontImagePath: 'assets/images/bingo_images/mager.png',
      backImagePath: "assets/images/bingo_images/amager.png",
      isFlipped: false
    ),
     BingoCard(
      frontText: "Prends soin de toi",
      frontImagePath: 'assets/images/bingo_images/soin.png',
      backImagePath: "assets/images/bingo_images/soinfait.png",
      isFlipped: false
    ),
  ];
  static List<BingoCard> getDefaultCards() {
    return List.from(_defaultCards);
  }
}

class BingoDataSoir {
  static final List<BingoCard> _defaultCards = [
    BingoCard(
      frontText: 'Trouve 3 choses positives dans ta journée',
      frontImagePath: "assets/images/bingo_images/merite.png",
      backImagePath: "assets/images/bingo_images/doue.png",
      isFlipped: false
    ),
    BingoCard(
      frontText: "Fais la vaisselle",
      frontImagePath: 'assets/images/bingo_images/fairevaisselle.png',
      backImagePath: "assets/images/bingo_images/vaissellefaite.png",
      isFlipped: false
    ),
    BingoCard(
      frontText: "Manger",
      frontImagePath: 'assets/images/bingo_images/mager.png',
      backImagePath: "assets/images/bingo_images/amager.png",
      isFlipped: false
    ),
    BingoCard(
      frontText: "Prépare tes affaires pour demain",
      frontImagePath: 'assets/images/bingo_images/prepare.png',
      backImagePath: "assets/images/bingo_images/pret.png",
      isFlipped: false
    ),
  ];
  static List<BingoCard> getDefaultCards() {
    return List.from(_defaultCards);
  }
}

class BingoDataCouche {
  static final List<BingoCard> _defaultCards = [
    BingoCard(
      frontText: 'Occupe toi sans écran',
      frontImagePath: "assets/images/bingo_images/lire.png",
      backImagePath: "assets/images/bingo_images/cerveau.png",
      isFlipped: false
    ),
    BingoCard(
      frontText: "Prendre le traitement",
      frontImagePath: 'assets/images/bingo_images/medocs.png',
      backImagePath: "assets/images/bingo_images/medocpris.png",
      isFlipped: false
    ),
    BingoCard(
      frontText: "Règle le réveil",
      frontImagePath: 'assets/images/bingo_images/reveil.png',
      backImagePath: "assets/images/bingo_images/reveilregle.png",
      isFlipped: false
    ),
    BingoCard(
      frontText: "Prends soin de toi",
      frontImagePath: 'assets/images/bingo_images/soin.png',
      backImagePath: "assets/images/bingo_images/soinfait.png",
      isFlipped: false
    ),
  ];
  static List<BingoCard> getDefaultCards() {
    return List.from(_defaultCards);
  }
}
