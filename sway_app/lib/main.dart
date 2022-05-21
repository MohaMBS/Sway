import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sway_app/auth/userAuth.dart';
import 'package:sway_app/screens/dashboard.dart';
import 'package:sway_app/screens/login.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //runApp(const MyApp());  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthChek(),
      routes: {
        '/dashboard': ((context) => const DashboardV())
      },
    );
  }

}


class AuthChek extends StatefulWidget {
  const AuthChek({ Key? key }) : super(key: key);

  @override
  State<AuthChek> createState() => _AuthChekState();
}

class _AuthChekState extends State<AuthChek> with AfterLayoutMixin<AuthChek> {

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.containsKey('UserAuth'));

    if (_seen) {
      String dataUser = prefs.getString('UserAuth')!;
      UserAuth.fromJson(jsonDecode(dataUser));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardV()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Login()));
    }
  }
  
 @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    checkFirstSeen();
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}