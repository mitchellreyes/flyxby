import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:math';
import 'constants.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'Profile Screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  double _moonOpacity = 0.1;
  int _moonLevel = 1;
  int _nextMoonLevel = 0;
  int _currentMoonXP = 2;
  bool _flewby = false;
  AnimationController controller;
  Animation animation;

  List<Container> entries = <Container>[
    Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('images/shinoa.jpg'),
                    radius: 30.0,
                  ),
                  Text(
                    'Twitch',
                    style: TextStyle(fontSize: 10.0),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '@Getmooched',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Follow me on twitch!',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('images/shinoa.jpg'),
              radius: 30.0,
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('images/shinoa.jpg'),
              radius: 30.0,
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _nextMoonLevel = ((_moonLevel + 300 * pow(2, _moonLevel / 7)) / 4).floor();
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

    if (entries.length % 2 > 0) {
      entries.add(Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Opacity(
                opacity: 0.1,
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/moon95.png'),
                  radius: 50.0,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  AssetImage calculateMoon() {
    if (_moonLevel < 30) {
      return AssetImage('images/moon.png');
    } else if (_moonLevel < 65) {
      return AssetImage('images/moon35.png');
    } else if (_moonLevel < 90) {
      return AssetImage('images/moon75.png');
    } else {
      return AssetImage('images/moon95.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Hero(
                      tag: 'Profile Icon',
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('images/shinoa.jpg'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'GetMooched',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Getmooched#1234',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          child: Transform.rotate(
                            angle: animation.value * (2 * pi),
                            child: AnimatedOpacity(
                              duration: Duration(seconds: 5),
                              opacity: _flewby ? 1.0 : 0.0,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/orbiter_vector.png'),
                                backgroundColor: Colors.transparent,
                                radius: 40.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: AvatarGlow(
                            endRadius: 35.0,
                            repeat: false,
                            duration: Duration(milliseconds: 3000),
                            child: AnimatedOpacity(
                              duration: Duration(seconds: 5),
                              opacity: _moonOpacity,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (!_flewby) {
                                      _flewby = true;
                                    }
                                    int xp_gain =
                                        ((log(_currentMoonXP) / log(2)) * 10)
                                            .floor();
                                    _currentMoonXP += xp_gain;

                                    while (_currentMoonXP >= _nextMoonLevel) {
                                      _moonLevel++;
                                      _nextMoonLevel += ((_moonLevel +
                                                  300 *
                                                      pow(2, _moonLevel / 7)) /
                                              4)
                                          .floor();
                                    }
                                    _moonOpacity = min(
                                        1.0,
                                        max(0.1,
                                            (log(_moonLevel + 1) / log(100))));
                                  });
                                },
                                behavior: HitTestBehavior.translucent,
                                child: CircleAvatar(
                                  backgroundImage: calculateMoon(),
                                  backgroundColor: Colors.transparent,
                                  radius: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 20.0,
                  child: Divider(
                    color: Colors.teal.shade200,
                  ),
                ),
                Expanded(
                  child: OrientationBuilder(builder: (context, orientation) {
                    return GridView.count(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 3,
                      shrinkWrap: true,
                      children: entries,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
