import 'package:flutter/material.dart';
import 'package:flyxby/profile_screen.dart';
import 'package:flyxby/register_screen.dart';
import 'package:flyxby/search_screen.dart';
import 'package:flyxby/welcome_screen.dart';
import 'package:flyxby/login_screen.dart';

void main() {
  runApp(FlyxBy());
}

class FlyxBy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SearchScreen.id: (context) => SearchScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
      },
    );
  }
}
