import 'dart:math';

import 'package:flutter/material.dart';

import 'colors.dart'; // Make sure to import your MColors file

class ColorUtils {
  // Method to get a random color from the list of colors
  static Color getRandomLightModeColor() {
    final List<Color> lightModeColors = [
      MColors.lightGray,
      MColors.softBeige,
      MColors.coolGray,
      MColors.warmLightTan,
      MColors.paleTaupe,
    ];

    return lightModeColors[Random().nextInt(lightModeColors.length)];
  }

  static Color getRandomDarkModeColor() {
    final List<Color> darkModeColors = [
      MColors.darkGray,
      MColors.charcoal,
      MColors.slateGray,
      MColors.deepTaupe,
      MColors.mutedNavy,
    ];

    return darkModeColors[Random().nextInt(darkModeColors.length)];
  }

  static Color getRandomNeutralColor() {
    final List<Color> neutralColors = [
      MColors.stoneGray,
      MColors.mediumBeige,
      MColors.mutedOlive,
      MColors.dustyMauve,
      MColors.warmTaupe,
    ];

    return neutralColors[Random().nextInt(neutralColors.length)];
  }
}
