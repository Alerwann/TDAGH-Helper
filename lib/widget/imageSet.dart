// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/profil_provider.dart';
import 'package:provider/provider.dart';

class ImageSet extends StatelessWidget {
  final double sizewidth;

  const ImageSet(double d, 
    {super.key,
      required this.sizewidth, 
    }
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilProvider>(
      builder: (context, profil, child) {
        if (profil.isDefaultImage) {
          return Image.asset(
            profil.profilImagePath,
            width: sizewidth,
            height: sizewidth,
            fit: BoxFit.cover,
          );
        }
        return Image.file(
          File(profil.profilImagePath),
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
