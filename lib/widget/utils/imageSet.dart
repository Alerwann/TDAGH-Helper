// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tdahelpe/providers/profil_provider.dart';
import 'package:provider/provider.dart';

class ImageSet extends StatelessWidget {
  final double sizewidth;

  const ImageSet(double d, {super.key, required this.sizewidth});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilProvider>(
      builder: (context, profil, child) {
        return FutureBuilder<bool>(
          future: File(profil.profilImagePath).exists(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return Image.file(
                File(profil.profilImagePath),
                width: sizewidth,
                height: sizewidth,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Si l'image ne charge pas, afficher l'image par défaut
                  return Image.asset(
                    'assets/images/defaultprofilimage.png',
                    width: sizewidth,
                    height: sizewidth,
                    fit: BoxFit.cover,
                  );
                },
              );
            }
            // Par défaut
            return Image.asset(
              'assets/images/defaultprofilimage.png',
              width: sizewidth,
              height: sizewidth,
              fit: BoxFit.cover,
            );
          },
        );
      },
    );
  }
}
