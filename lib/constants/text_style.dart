import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final textStyleLarge = textStyleWithGoogleFont(fontSize: 18);

final textStyleMedium = textStyleWithGoogleFont(fontSize: 16);

final textStyleBold = textStyleWithGoogleFont(fontWeight: FontWeight.bold);

final textStylePlain = textStyleWithGoogleFont();

TextStyle textStyleWithGoogleFont({
  double fontSize = 14,
  FontWeight? fontWeight,
}) {
  return GoogleFonts.mPlusRounded1c(
    textStyle: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
  );
}
