import 'package:auto_size_text/auto_size_text.dart';
import 'package:Difesa/shared/widgets/sos_button.dart';
import 'package:flash_animation/flash_animation.dart';
import 'package:flutter/material.dart';

class Switcher extends StatelessWidget {
  final FlashAnimation anim = FlashAnimation(
    gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
    child: Text('Hi'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Center(
                child: SOSButton(
                  fromEmergency: false,
                  startColor: Colors.blue,
                  endColor: Colors.blue,
                  child: Center(
                    child: AutoSizeText(
                      'Safe',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                      maxLines: 1,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('Safe_Dashboard');
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Center(
                child: SOSButton(
                  fromEmergency: false,
                  startColor: Colors.redAccent[400],
                  endColor: Colors.deepOrange,
                  child: Center(
                    child: AutoSizeText(
                      'Emergency',
                      style: TextStyle(color: Colors.white, fontSize: 50),
                      maxLines: 1,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('Emergency_Dashboard');
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
