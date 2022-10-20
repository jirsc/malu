import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:malu/utils/ui/icons/font_awesome_icons.dart';
//import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  //textTheme: GoogleFonts.openSansTextTheme(),
  fontFamily: 'Muli',
  primaryColorDark: const Color(0xFFff5b01),
  primaryColorLight: const Color(0xFFffbb67),
  primaryColor: const Color(0xFFffa700),
  colorScheme: const ColorScheme.light(secondary: Color(0xFFffe700)),
  scaffoldBackgroundColor: const Color(0xFFffffff),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
    ),
  ),
);

// class CustomIcon extends FontAwesome4 {
//   CustomIcon({Key? key}) : super(key: key);
// }
