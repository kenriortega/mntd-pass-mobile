import 'package:flutter/material.dart';
import 'package:mntd_mobile/utils/themes/colors.dart';

final themeDark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Montserrat',
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0.0,
    ),
    scaffoldBackgroundColor: GFColors.kPrimary800Color,
    dialogBackgroundColor: GFColors.kPrimary700Color,
    focusColor: GFColors.kPrimaryButtomColor);
