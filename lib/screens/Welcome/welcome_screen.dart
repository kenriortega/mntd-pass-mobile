import 'package:flutter/material.dart';
import 'package:mntd_mobile/Screens/Welcome/components/body.dart';

class WelcomeScreen extends StatelessWidget {
  static Route<dynamic> route(){
    return MaterialPageRoute(builder: (cotext)=> WelcomeScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
