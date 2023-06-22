
import 'package:flutter/material.dart';
import 'package:run_away_admin/core/color_constants.dart';

class StackImage extends StatelessWidget {
  const StackImage(
      {super.key,
      required this.kHeight,
      required this.kWidth,
      required this.imageName});

  final double kHeight;
  final double kWidth;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHeight,
      width: kWidth,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: kGrey.withOpacity(0.5), blurRadius: 5)
        ],
        color:kWhite,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(
            imageName,
          ),
        ),
      ),
    );
  }
}
