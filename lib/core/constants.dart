import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_constants.dart';

final kTitleText = GoogleFonts.robotoFlex(
    fontWeight: FontWeight.bold, fontSize: 22, color: kBlack);

final kHeadingText = GoogleFonts.roboto(
    fontWeight: FontWeight.bold, fontSize: 20, color: kBlack);

final kSubTitleText = GoogleFonts.roboto(
    fontWeight: FontWeight.bold, fontSize: 16, color: kBlack);

final buttonStyleRound = ButtonStyle(
  shape: const MaterialStatePropertyAll(
    StadiumBorder(),
  ),
  shadowColor: MaterialStateProperty.all(Colors.blue),
  elevation: MaterialStateProperty.all(5),
);

void snackBar(BuildContext context, String aText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        aText,
      ),
    ),
  );
}
