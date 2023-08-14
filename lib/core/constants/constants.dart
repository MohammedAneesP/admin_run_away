import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away_admin/core/color_constants.dart';

final kTitleText = GoogleFonts.robotoFlex(
    fontWeight: FontWeight.bold, fontSize: 22, color: kBlack);

final kHeadingText = GoogleFonts.roboto(
    fontWeight: FontWeight.bold, fontSize: 20, color: kBlack);

final kSubTitleText = GoogleFonts.roboto(
    fontWeight: FontWeight.bold, fontSize: 16, color: kBlack);

final kBlueThinText =
    GoogleFonts.roboto(color: kBlue, fontSize: 16, fontWeight: FontWeight.w300);

final buttontextWhite = GoogleFonts.inter(
    fontSize: 18, fontWeight: FontWeight.normal, color: kWhite);

final loginTitle = GoogleFonts.inter(fontSize: 25, fontWeight: FontWeight.bold);

final buttonTextBlack = GoogleFonts.inter(
    fontSize: 18, fontWeight: FontWeight.normal, color: kBlack);

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
final splashTitle = GoogleFonts.rocknRollOne(
    fontSize: 70, fontWeight: FontWeight.bold, color: kSplashTitleClr);

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
const buttonAddStyle = ButtonStyle(
  fixedSize: MaterialStatePropertyAll(Size(20, 45)),
  foregroundColor: MaterialStatePropertyAll(kBlue),
  backgroundColor: MaterialStatePropertyAll(kWhite),
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
