import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.twistingDots(
          leftDotColor: const Color.fromARGB(255, 245, 47, 3),
          rightDotColor: const Color.fromARGB(255, 5, 241, 24),
          size: 200,
        ),
      ),
    );
  }
}
