import 'package:flutter/material.dart';
import 'screens/splashScreen.dart';
void main() {
  runApp(MntdSecrets());
}

class MntdSecrets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Todas sus apliaciones deben de estar dentro de Material App para poder
    // hacer uso de las facilidades de Material Design puede omitirce esto pero
    // no podran hacer uso de estos widgets de material.dart
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), //  Tema Claro
//      theme: ThemeData.dark(), // Tema Oscuro
      home: SplashScreen(),
    );
  }
}