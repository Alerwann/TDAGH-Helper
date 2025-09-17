import 'package:flutter/material.dart';

class Quetesfinales extends StatefulWidget {
  final List listTaches;
  const Quetesfinales({super.key, required this.listTaches});

  @override
  State<Quetesfinales> createState() => _QuetesfinalesState();
}

class _QuetesfinalesState extends State<Quetesfinales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [Text("Liste finale"), Text(widget.listTaches.toString())],
        ),
      ),
    );
  }
}
