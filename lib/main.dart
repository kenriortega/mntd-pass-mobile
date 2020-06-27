import 'package:flutter/material.dart';
import 'package:mntd_mobile/providers/SecretCardProvider.dart';
import 'package:mntd_mobile/providers/ThemeSettingProvider.dart';
import 'package:mntd_mobile/utils/themes/apptheme.dart';
import 'package:provider/provider.dart';
import 'screens/splashScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SecretCardProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeSettingProvider(),
        ),
      ],
      child: MntdSecrets(),
    ),
  );
}

class MntdSecrets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeSettingProvider>(
      builder: (context, appState, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appState.isDarkModeOn ? ThemeMode.light : ThemeMode.dark,
          home: SplashScreen(),
        );
      },
    );
  }
}
