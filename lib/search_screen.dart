import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:math';

import 'package:flyxby/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'Search Screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  void getCurrentUser() async {
    final user = await _auth.currentUser();
    try {
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      //TODO: Need to catch exception
      print(e);
    }
  }

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 10), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.repeat();
      }
    });
    controller.addListener(() {
      setState(() {});
    });
    getCurrentUser();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is the main search screen'),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Transform.rotate(
                          angle: animation.value * (2 * pi),
                          child: Icon(MaterialCommunityIcons.orbit),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            print('Profile image was pressed');
                          },
                          child: CircleAvatar(
                            radius: 25.0,
                            child: Icon(Ionicons.md_settings),
                          ),
                          elevation: 2.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ProfileScreen.id);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Hero(
                                  tag: 'Profile Icon',
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage:
                                        AssetImage('images/shinoa.jpg'),
                                  ),
                                ),
                              ),
                              Text(
                                'GetMooched#1234',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          elevation: 2.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            print('Profile image was pressed');
                          },
                          child: CircleAvatar(
                            radius: 25.0,
                            child: Icon(Ionicons.ios_moon),
                          ),
                          elevation: 2.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
