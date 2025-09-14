import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/schema/bingo_card_schema.dart';

class SimpleFlipCard extends StatefulWidget {
  final BingoCard cardData;
  final bool isFlipped;
  final VoidCallback onTap;

  const SimpleFlipCard({
    super.key,
    required this.cardData,
    required this.isFlipped,
    required this.onTap,
  });

  @override
  State<SimpleFlipCard> createState() => _SimpleFlipCardState();
}

class _SimpleFlipCardState extends State<SimpleFlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    if (widget.cardData.isFlipped) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(SimpleFlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si l'état de la carte change, joue l'animation

    if (widget.isFlipped != oldWidget.isFlipped) {
      if (widget.isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse(); // Animation vers l'avant
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          bool showFront = _controller.value < 0.5;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateY(_controller.value * 3.14159), // Rotation
            child: Card(
              child: Container(
                padding: EdgeInsets.all(8),
                color: showFront
                    ? const Color.fromARGB(255, 232, 112, 112)
                    : const Color.fromARGB(255, 188, 236, 189),
                child: Center(
                  child: showFront
                      ? _buildFront()
                      : Transform(
                          transform: Matrix4.identity()..rotateY(3.14159),
                          alignment: Alignment.center,
                          child: _buildBack(),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFront() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          widget.cardData.frontImagePath,
          height: 110,
          width: 135,
        ), // Remplace par ton image
        SizedBox(height: 8),
        Text(
          widget.cardData.frontText,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Ce qui s'affiche derrière
  Widget _buildBack() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(widget.cardData.backImagePath, height: 110, width: 135),
        SizedBox(height: 8),
        Text("Terminé !"),
      ],
    );
  }
}
