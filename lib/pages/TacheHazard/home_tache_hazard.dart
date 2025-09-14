import 'package:flutter/material.dart';


class HomeTacheHazard extends StatefulWidget {
  const HomeTacheHazard({super.key});

  @override
  State<HomeTacheHazard> createState() => _HomeTacheHazardState();
}

class _HomeTacheHazardState extends State<HomeTacheHazard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Text('Tache au hazard'));
  }
}
