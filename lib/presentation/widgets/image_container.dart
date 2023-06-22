import 'dart:io';

import 'package:flutter/material.dart';
import 'package:run_away_admin/core/color_constants.dart';

class ContainerForImage extends StatelessWidget {
  const ContainerForImage({
    super.key,
    required this.kHeight,
    required this.kWidth,
    required this.imagePath,
  });

  final double kHeight;
  final double kWidth;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHeight,
      width: kWidth,
      decoration: BoxDecoration(
        color: kBlack.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: FileImage(
              File(
                imagePath,
              ),
            ),
            fit: BoxFit.contain),
      ),
    );
  }
}
