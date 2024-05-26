import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChefsPocketTheme {
  static TextTheme lightTextTheme = TextTheme(
    //titolo grande delle schermate principali: Oggi, Salvati, Crea ricetta, Piano Alimentare, Lista
    titleLarge: TextStyle(
      fontFamily: "Adamina",
      fontSize: 40,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF557F9F),
    ),
    //titoli widget: pasti, note, timer,step
    titleMedium: TextStyle(
      fontFamily: "Adamina",
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF557F9F),
    ),
    //sottotitoli per form e sezioni
    bodyLarge: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    //corpo note, descrizioni, ingredienti
    bodyMedium: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontFamily: "Adamina",
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Color(0xFFFFFED9),
    ),
  );

  static ThemeData light(){
    return ThemeData(
      useMaterial3: true,

       colorScheme: const ColorScheme(
          brightness: Brightness.light,
          background: Color(0xFFFFFDF4), 
          tertiary: Color(0xFFFFFED9),
          onBackground: Color(0xFFFFFDF4),
           primary: Color(0xFF557F9F), 
          onPrimary: Color(0xFF557F9F),
           secondary: Color(0xFF557F9F), 
           onSecondary: Colors.white,
           error: Colors.red,
           onError: Colors.white,
           surface: Colors.white,
           onSurface: Color(0xFF557F9F),
        ),
      textTheme: lightTextTheme,
   
   
    );
  }
}
