import 'package:Difesa/pages/AR.dart';
import 'package:Difesa/pages/emergency_dashboard.dart';
import 'package:Difesa/pages/emergency_map.dart';
import 'package:Difesa/pages/emergency_people_list.dart';
import 'package:Difesa/pages/login_page.dart';
import 'package:Difesa/pages/main_dashboard.dart';
import 'package:Difesa/pages/photo_capture.dart';
import 'package:Difesa/pages/self_defense.dart';
import 'package:Difesa/pages/sos.dart';
import 'package:Difesa/pages/switcher.dart';
import 'package:Difesa/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
      create: (BuildContext context) {
        return ProfileProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => LoginPage(),
          'Switcher': (context) => Switcher(),
          'sos': (context) => SOSPage(),
          'Safe_Dashboard': (context) => MainDashboard(),
          'Emergency_Dashboard': (context) => EmergencyDashboard(),
          'Defense': (context) => SelfDefense(),
          'Strategy': (context) => EmergencyInfoPage(),
          'AR': (context) => ARDetectionPage(),
          'Shake': (context) => PhotoCapture(),
          'Emergency_List': (_) => EmergencyPeopleList(),
          'Emergency_Map': (_) => EmergencyMap(),
        },
      ),
    );
  }
}
