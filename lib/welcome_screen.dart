import 'package:flutter/material.dart';
import 'package:flyxby/login_screen.dart';
import 'package:flyxby/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'Welcome Screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Center(
                  child: Text(
                    'Fly x By',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: MaterialButton(
                        child: Text('Login'),
                        height: 50.0,
                        color: Colors.red,
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                      ),
                    ),
                    MaterialButton(
                      child: Text('Register'),
                      height: 50.0,
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
