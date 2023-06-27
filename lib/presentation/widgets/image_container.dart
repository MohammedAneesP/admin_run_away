import 'dart:io';

import 'package:flutter/material.dart';
import 'package:run_away_admin/core/color_constants.dart';

class ContainerForImage extends StatelessWidget {
  const ContainerForImage({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return Container(
      height: kHeight * .35,
      width: kWidth * 0.7,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kBlack.withOpacity(0.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: kHeight * .3,
            width: kWidth * .65,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(
                    File(
                      imagePath,
                    ),
                  ),
                  fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerForNetworkImage extends StatelessWidget {
  const ContainerForNetworkImage({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return Container(
      height: kHeight * .35,
      width: kWidth * 0.7,
      decoration: BoxDecoration(
        color: kBlack.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: kHeight * .3,
            width: kWidth * .65,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
