import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_constants.dart';

final kTitleText = GoogleFonts.rocknRollOne(fontWeight: FontWeight.bold,fontSize: 22,color: kBlack);

final kHeadingText = GoogleFonts.rocknRollOne(fontWeight: FontWeight.bold,fontSize: 20,color: kBlack);


final kSubTitleText = GoogleFonts.rocknRollOne(fontWeight: FontWeight.bold,fontSize: 16,color: kBlack);


void snackBar(BuildContext context, String aText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        aText,
      ),
    ),
  );
}