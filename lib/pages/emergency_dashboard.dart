import 'dart:math';

import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:Difesa/pages/main_dashboard.dart';
import 'package:Difesa/providers/profile_provider.dart';
import 'package:Difesa/shared/constants.dart';
import 'package:Difesa/shared/widgets/bottom_bar.dart';
import 'package:Difesa/shared/widgets/circular_button.dart';
import 'package:Difesa/shared/widgets/drawer.dart';
import 'package:Difesa/shared/widgets/profile_card.dart';
import 'package:Difesa/shared/widgets/round_app_bar.dart';
import 'package:Difesa/shared/widgets/sos_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmergencyDashboard extends StatefulWidget {
  @override
  _EmergencyDashboardState createState() => _EmergencyDashboardState();
}

class _EmergencyDashboardState extends State<EmergencyDashboard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  void _runAnimation() async {
    while (true) {
      await _animationController.forward();
      await _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      drawer: MyDrawer(),
      body: Stack(
        children: [
          RoundedAppBar(
            margin: 8,
          ),
          Column(
            children: [
              Container(
                height: 100,
              ),
              Expanded(
                flex: 3,
                child: SOSButton(
                  index: 0,
                  startColor: Gradients.startColor,
                  endColor: Gradients.endColor,
                  onPressed: () {
                    Gradients.showMyDialog(
                      context,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShakeAnimatedWidget(
                            enabled: true,
                            duration: Duration(milliseconds: 300),
                            shakeAngle: Rotation.deg(z: 5),
                            curve: Curves.linear,
                            child: Transform.rotate(
                              angle: (pi / 180) * -35,
                              child: Icon(Constants.shakeIcon,
                                  size: 70, color: Color(0xffffc400)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Shake to capture and activate emergency',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              // fontWeight:
                              // FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      () {},
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Shake',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      // Text(
                      //   'Press to capture, activate emergency',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w300,
                      //   ),
                      // ),
                    ],
                  ),
                  radius: 60,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 3,
                child: SOSButton(
                  index: 1,
                  startColor: Gradients.startColor,
                  endColor: Gradients.endColor,
                  onPressed: () => Navigator.of(context).pushNamed('sos'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SOS',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      // Text(
                      //   'Press to ______',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w300,
                      //   ),
                      // ),
                    ],
                  ),
                  radius: 60,
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: CircularButtonDashboard(
                        fromEmergency: true,
                        icon: Constants.policeIcon,
                        text: 'Police Stations',
                        onPressed: Constants.policeStaionFunction,
                      ),
                    ),
                    Expanded(
                      child: CircularButtonDashboard(
                        fromEmergency: true,
                        icon: Constants.sirenIcon,
                        text: 'Play Siren',
                        onPressed: () {
                          try {
                            MainDashboard.player.clearCache();
                            MainDashboard.player.play('siren.mp3');
                          } catch (e) {}
                          Gradients.showMyDialog(
                            context,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RotationTransition(
                                  turns: Tween(begin: 0.0, end: -.1)
                                      .chain(
                                          CurveTween(curve: Curves.elasticIn))
                                      .animate(_animationController),
                                  child: Icon(Icons.notifications_active,
                                      size: 70, color: Colors.red),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Playing Siren\n\n Tap to play again',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 20,
                                    // fontWeight:
                                    // FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            () {
                              try {
                                MainDashboard.player.clearCache();
                                MainDashboard.player.play('siren.mp3');
                              } catch (e) {}
                            },
                          );
                          _runAnimation();
                        },
                      ),
                    ),
                    Expanded(
                      child: CircularButtonDashboard(
                        fromEmergency: true,
                        icon: Constants.arIcon,
                        text: 'AR Detection',
                        onPressed: () => Navigator.of(context).pushNamed('sos'),
                      ),
                    ),
                    Expanded(
                      child: CircularButtonDashboard(
                        fromEmergency: true,
                        icon: Constants.taxiIcon,
                        text: 'Taxi/Cab',
                        onPressed: Constants.taxiButton,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  // height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      'I\'m safe',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('Safe_Dashboard');
                      // FlutterOpenWhatsapp.sendSingleMessage('919810356529', 'Hi');
                    },
                  ),
                ),
              )
            ],
          ),
          Positioned.fill(
            child: profileProvider.isProfileOpened == true
                ? GestureDetector(
                    onTap: () {
                      print('ahebf');
                      profileProvider.closeProfile();
                    },
                    child: Container(
                      color: Colors.black38,
                      constraints: BoxConstraints.expand(),
                    ),
                  )
                : SizedBox(),
          ),
          Positioned(right: 0, top: 0, child: ProfileCard()),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomTimeBar(
            child: Container(
              decoration: BoxDecoration(color: Colors.transparent),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(253, 137, 1, 1),
                          Color.fromRGBO(244, 102, 65, 1),
                        ]),
                        // color: Colors.red,
                        border: Border.all(width: 1)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('5 min 10 s',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24)),
                          Text('Time to reach',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('252m',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24)),
                                Icon(
                                  Icons.pin_drop,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Text('Distance from you',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(stops: [
                            0.6,
                            1
                          ], colors: [
                            Color.fromRGBO(244, 102, 65, 1),
                            Color.fromRGBO(253, 137, 1, 1)
                          ]),
                          color: Colors.red),
                    ),
                  ),
                ],
              ),
              height: 100,
              // color: Colors.red,
            ),
          ),
          profileProvider.isProfileOpened == true
              ? Positioned.fill(
                  child: GestureDetector(
                  onTap: () {
                    print('Closing');
                    profileProvider.closeProfile();
                  },
                  child: Container(
                    color: Colors.black38,
                  ),
                ))
              : SizedBox()
        ],
      ),
    );
  }
}
