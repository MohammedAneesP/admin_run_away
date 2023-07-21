import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../color_constants.dart';

final kTitleText = GoogleFonts.robotoFlex(
    fontWeight: FontWeight.bold, fontSize: 22, color: kBlack);

final kHeadingText = GoogleFonts.roboto(
    fontWeight: FontWeight.bold, fontSize: 20, color: kBlack);

final kSubTitleText = GoogleFonts.roboto(
    fontWeight: FontWeight.bold, fontSize: 16, color: kBlack);

final kitalicText = GoogleFonts.roboto(
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w300,
    fontSize: 16,
    color: kBlue);
final kitalicSmallText = GoogleFonts.roboto(
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w300,
    fontSize: 14,
    color: kBlue);

const buttonStyleRound = ButtonStyle(
  fixedSize: MaterialStatePropertyAll(Size(370, 50)),
  foregroundColor: MaterialStatePropertyAll(kWhite),
  backgroundColor: MaterialStatePropertyAll(Colors.blue),
  shape: MaterialStatePropertyAll(
    StadiumBorder(),
  ),
);  

const buttonStyleRoundSmall = ButtonStyle(
  fixedSize: MaterialStatePropertyAll(Size(140, 45)),
  foregroundColor: MaterialStatePropertyAll(kWhite),
  backgroundColor: MaterialStatePropertyAll(Colors.blue),
  shape: MaterialStatePropertyAll(
    StadiumBorder(),
  ),
);


void anSnackBarFunc(
    {required BuildContext context,
    required String aText,
    required Color anColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(aText),
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      backgroundColor: anColor,
    ),
  );
}
