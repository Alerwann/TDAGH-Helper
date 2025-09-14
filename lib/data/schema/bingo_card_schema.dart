class BingoCard {
  final String frontText;
  final String frontImagePath;
  final String backImagePath;
  bool isFlipped;

  BingoCard({
    required this.frontText,
    required this.frontImagePath,
    required this.backImagePath,
    required this.isFlipped,
  });

  void flip() {
    isFlipped = !isFlipped;
  }

  void setFlipped(bool flipped) {
    isFlipped = flipped;
  }
}
