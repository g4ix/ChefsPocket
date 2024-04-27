import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChefsPocketTheme {
  static TextTheme lightTextTheme = TextTheme(
    //titolo grande delle schermate principali: Oggi, Salvati, Crea ricetta, Piano Alimentare, Lista
    titleLarge: GoogleFonts.adamina(
      fontSize: 25,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF557F9F),
    ),
    //titoli widget: pasti, note, timer,step
    titleMedium: GoogleFonts.adamina(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF557F9F),
    ),
    //sottotitoli per form e sezioni
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    //corpo note, descrizioni, ingredienti
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  );

  static ThemeData light(){
    return ThemeData(
      useMaterial3: true,

      primaryColor: Colors.white,
      hintColor:  Colors.black.withOpacity(0.5), //testo dei form prima di essere compilati
      scaffoldBackgroundColor: const Color(0xFFFEEE95).withOpacity(0.1),
      textTheme: lightTextTheme,
      appBarTheme: const AppBarTheme(
        color: Color(0xFF557F9F),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      
    );
  }
}
