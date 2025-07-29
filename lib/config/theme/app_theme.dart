import 'package:flutter/material.dart';
import 'package:music_app/core/constants/colors.dart';

class AppTheme {
  static ThemeData get light => LightTheme.theme;
  static ThemeData get dark => DarkTheme.theme;
}

class LightTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    iconTheme: const IconThemeData(color: AppColors.myBlack),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: AppColors.myBlack)),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.myGrey,
      elevation: 0,
      foregroundColor: AppColors.myBlack,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.myBlack,
      secondary: Colors.blueAccent,
      surface: AppColors.myGrey,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.myBlack;
        }
        return AppColors.myGrey;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.myBlack.withValues(alpha: 0.5);
        }
        return AppColors.myBlack;
      }),
    ),
  );
}

class DarkTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.myBlack,
    iconTheme: const IconThemeData(color: AppColors.myGrey),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: AppColors.myGrey)),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.myGrey2,
      elevation: 0,
      foregroundColor: AppColors.myBlack,
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.myGrey,
      secondary: Colors.tealAccent,
      surface: AppColors.myGrey2,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.myBlack;
        }
        return AppColors.myGrey;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.myBlack.withValues(alpha: 0.5);
        }
        return AppColors.myGrey.withValues(alpha: 0.5);
      }),
    ),
  );
}
