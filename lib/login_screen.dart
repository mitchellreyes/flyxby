import 'package:flutter/material.dart';
import 'package:flyxby/search_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'Login Screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _passwordObstruction = true;

  void toggleObstruction() {
    setState(() {
      _passwordObstruction = !_passwordObstruction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //need to change this app bar
      appBar: AppBar(
        title: Text('This is the login screen'),
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'Email Address'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: TextFormField(
                  obscureText: _passwordObstruction,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: MaterialButton(
                  child: Text('Login'),
                  color: Colors.blue,
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      //process the data to firebase
                      //then push named route
                    }
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => SearchScreen()),
                        ModalRoute.withName(SearchScreen.id));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
