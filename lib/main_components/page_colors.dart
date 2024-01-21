// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageColor {
  // used colors in the app
  static const items_col = Color.fromARGB(230, 7, 164, 255);
  static const background_col1 = Color.fromARGB(64, 0, 0, 0);
  static const background_col2 = Color.fromARGB(181, 0, 0, 0);
  static const background_col3 = Color.fromARGB(96, 0, 0, 0);
  static const menu_color = Colors.white;
  static const circ_col = Color.fromARGB(216, 206, 237, 255);
  static const shadow_col = Color.fromARGB(57, 0, 0, 0);
  static const rectangle_col = Color.fromARGB(122, 143, 205, 255);
  static const rectangle_border_col = Color.fromARGB(255, 110, 190, 255);
  static const chosen_rectangle_col = Color.fromARGB(125, 33, 149, 243);
  static const chosen_rectangle_border_col = Color.fromARGB(255, 110, 190, 255);
}

class StaticTextsStyle {
  // used texts styles in the app
  static final predictions_style =
      GoogleFonts.barlow(color: Colors.white, fontSize: 21);

  static final hour_style = GoogleFonts.barlow(
    color: Colors.white,
    fontSize: 32,
  );
  static final geohash_style =
      GoogleFonts.barlow(color: Colors.white, fontSize: 32);

  static final city_name_style = GoogleFonts.raleway(
    color: Colors.white,
    fontSize: 85,
    letterSpacing: 4,
    fontWeight: FontWeight.w400,
  );
  static final menu_style = GoogleFonts.raleway(
    color: Colors.white,
    fontSize: 17,
    letterSpacing: 4,
    fontWeight: FontWeight.w300,
  );
  static final menu_style2 = GoogleFonts.raleway(
    color: Colors.white,
    fontSize: 15,
    letterSpacing: 4,
    fontWeight: FontWeight.w300,
  );
}
