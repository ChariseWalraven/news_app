import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData newsAppTheme = ThemeData(
  primarySwatch: Colors.amber,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: TextTheme(
    displaySmall: const TextStyle(
      letterSpacing: 0.05,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: 36.0,
    ),
    bodySmall: TextStyle(
      color: Colors.grey.shade600,
    ),
  ),
);
