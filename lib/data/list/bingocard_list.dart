import 'package:flutter/cupertino.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';

import '../schema/bingo_card_schema.dart';

class BingoDataMorning {
  static List<BingoCard> getCards(BuildContext context) {
    return [
      BingoCard(
        frontText: AppLocalizations.of(context)!.faireLit,
        frontImagePath: 'assets/images/bingo_images/litdefait.png',
        backImagePath: 'assets/images/bingo_images/litfait.png',
        isFlipped: false,
      ),
      BingoCard(
        frontText: AppLocalizations.of(context)!.laverDent,
        frontImagePath: 'assets/images/bingo_images/dentsalle.png',
        backImagePath: 'assets/images/bingo_images/dentpropre.png',
        isFlipped: false,
      ),
      BingoCard(
        frontText: AppLocalizations.of(context)!.prendreTraitement,
        frontImagePath: 'assets/images/bingo_images/medocs.png',
        backImagePath: "assets/images/bingo_images/medocpris.png",
        isFlipped: false,
      ),
      BingoCard(
        frontText: AppLocalizations.of(context)!.douche,
        frontImagePath: "assets/images/bingo_images/douche.png",
        backImagePath: "assets/images/bingo_images/doucheprise.png",
        isFlipped: false,
      ),
    ];
  }
}

class BingoDataMidi {
  static List<BingoCard> getCards(BuildContext context) {
    return [
      BingoCard(
        frontText: AppLocalizations.of(context)!.boire,
        frontImagePath: "assets/images/bingo_images/boire.png",
        backImagePath: "assets/images/bingo_images/bu.png",
        isFlipped: false,
      ),
      BingoCard(
        frontText: AppLocalizations.of(context)!.prendreTraitement,
        frontImagePath: 'assets/images/bingo_images/medocs.png',
        backImagePath: "assets/images/bingo_images/medocpris.png",
        isFlipped: false,
      ),
      BingoCard(
        frontText: AppLocalizations.of(context)!.manger,
        frontImagePath: 'assets/images/bingo_images/mager.png',
        backImagePath: "assets/images/bingo_images/amager.png",
        isFlipped: false,
      ),
      BingoCard(
        frontText: AppLocalizations.of(context)!.soin,
        frontImagePath: 'assets/images/bingo_images/soin.png',
        backImagePath: "assets/images/bingo_images/soinfait.png",
        isFlipped: false,
      ),
    ];
  }
}

class BingoDataSoir {
  static List<BingoCard> getCards(BuildContext context) {
    return [
      BingoCard(
        frontText: AppLocalizations.of(context)!.chosePositive,
        frontImagePath: "assets/images/bingo_images/merite.png",
        backImagePath: "assets/images/bingo_images/doue.png",
        isFlipped: false,
      ),
      BingoCard(
        frontText: AppLocalizations.of(context)!.faisLaVaisselle,
        frontImagePath: 'assets/images/bingo_images/fairevaisselle.png',
        backImagePath: "assets/images/bingo_images/vaissellefaite.png",
        isFlipped: false,
      ),
      BingoCard(
        frontText: AppLocalizations.of(context)!.manger,
        frontImagePath: 'assets/images/bingo_images/mager.png',
        backImagePath: "assets/images/bingo_images/amager.png",
        isFlipped: false,
      ),
      BingoCard(
        frontText: AppLocalizations.of(context)!.prepaDemain,
        frontImagePath: 'assets/images/bingo_images/prepare.png',
        backImagePath: "assets/images/bingo_images/pret.png",
        isFlipped: false,
      ),
    ];
  }
}

class BingoDatacoucher {
  static List<BingoCard> getCards(BuildContext context) {
    return [
      BingoCard(
        frontText: AppLocalizations.of(context)!.finEcran,
        frontImagePath: "assets/images/bingo_images/lire.png",
        backImagePath: "assets/images/bingo_images/cerveau.png",
        isFlipped: false,
      ),
      BingoCard(
        frontText: AppLocalizations.of(context)!.prendreTraitement,
        frontImagePath: 'assets/images/bingo_images/medocs.png',
        backImagePath: "assets/images/bingo_images/medocpris.png",
        isFlipped: false,
      ),
      BingoCard(
        frontText: AppLocalizations.of(context)!.reveil,
        frontImagePath: 'assets/images/bingo_images/reveil.png',
        backImagePath: "assets/images/bingo_images/reveilregle.png",
        isFlipped: false,
      ),
      BingoCard(
        frontText: AppLocalizations.of(context)!.soin,
        frontImagePath: 'assets/images/bingo_images/soin.png',
        backImagePath: "assets/images/bingo_images/soinfait.png",
        isFlipped: false,
      ),
    ];
  }
}
