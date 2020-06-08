import 'package:flutter/material.dart';
import 'package:mntd_mobile/Screens/Login/login_screen.dart';
import 'package:mntd_mobile/Screens/Signup/components/background.dart';
import 'package:mntd_mobile/components/already_have_an_account_acheck.dart';
import 'package:mntd_mobile/components/rounded_button.dart';
import 'package:mntd_mobile/components/rounded_input_field.dart';
import 'package:mntd_mobile/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[           
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/registrarse.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              hintStyle: TextStyle(color: Colors.black),
              textStyle: TextStyle(color: Colors.black),
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
              hintStyle: TextStyle(color: Colors.black),
              textStyle: TextStyle(color: Colors.black),
            ),
            RoundedButton(
              text: "SIGN UP",
              color: Colors.green,
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
