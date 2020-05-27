import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flyxby/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class RegisterScreen extends StatefulWidget {
  static const String id = 'Register Screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firestore = Firestore.instance;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
  bool showSpinner = false;

  String email;
  String password;
  String username;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        //need to change this app bar
        appBar: AppBar(
          title: Text('This is the registration screen'),
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
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(hintText: 'Email Address'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter an email address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value.trim();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Desired Username'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a desired username';
                      } else {
                        return alphanumeric.hasMatch(value)
                            ? null
                            : 'Only letters and numbers allowed in usernames';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      username = value.trim();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: TextFormField(
                    obscureText: true,
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
                    child: Text('Register'),
                    color: Colors.blue,
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        //process the data to firebase
                        //then push named route
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            try {
                              int min = 0000;
                              int max = 9999;
                              var randomizer = Random();
                              var rNum = min + randomizer.nextInt(max - min);
                              String flyxby_id =
                                  '#' + rNum.toString().padLeft(4, '0');
                              QuerySnapshot id_result = await Firestore.instance
                                  .collection('users')
                                  .where('flyxby_id', isEqualTo: flyxby_id)
                                  .limit(1)
                                  .getDocuments();
                              QuerySnapshot username_result = await Firestore
                                  .instance
                                  .collection('users')
                                  .where('username', isEqualTo: username)
                                  .limit(1)
                                  .getDocuments();

                              while (id_result.documents.length >= 1 &&
                                  username_result.documents.length >= 1) {
                                rNum = min + randomizer.nextInt(max - min);
                                flyxby_id =
                                    '#' + rNum.toString().padLeft(4, '0');
                                id_result = await Firestore.instance
                                    .collection('users')
                                    .where('flyxby_id', isEqualTo: flyxby_id)
                                    .limit(1)
                                    .getDocuments();
                                username_result = await Firestore.instance
                                    .collection('users')
                                    .where('username', isEqualTo: username)
                                    .limit(1)
                                    .getDocuments();
                              }
                              _firestore
                                  .collection('users')
                                  .document(newUser.user.uid)
                                  .setData({
                                'flyxby_id': flyxby_id,
                                'uid': newUser.user.uid,
                                'username': username,
                              });
                            } catch (e) {
                              //TODO: Need to think of what to do if this fails. Will probably need to delete the user then go back to welcome screen.
                              print(e);
                            }
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SearchScreen()),
                                ModalRoute.withName(SearchScreen.id));
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          //TODO: Need to show exception somehow
                          print(e);
                        }
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
