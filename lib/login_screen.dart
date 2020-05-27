import 'package:flutter/material.dart';
import 'package:flyxby/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'Login Screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _passwordObstruction = true;

  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  bool showSpinner = false;
  void toggleObstruction() {
    setState(() {
      _passwordObstruction = !_passwordObstruction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: Scaffold(
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
                    decoration:
                        const InputDecoration(hintText: 'Email Address'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter an email address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
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
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: MaterialButton(
                    child: Text('Login'),
                    color: Colors.blue,
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        //process the data to firebase
                        //then push named route
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (user != null) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SearchScreen()),
                                ModalRoute.withName(SearchScreen.id));
                          }
                        } catch (e) {
                          print(e);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
