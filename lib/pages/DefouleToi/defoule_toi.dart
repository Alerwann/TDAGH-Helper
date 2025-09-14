import 'package:flutter/material.dart';

class HomeDefouleToi extends StatefulWidget {
  const HomeDefouleToi({super.key});

  @override
  State<HomeDefouleToi> createState() => _HomeDefouleToiState();
}

class _HomeDefouleToiState extends State<HomeDefouleToi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Text("Defoule Toi"));
  }
}
