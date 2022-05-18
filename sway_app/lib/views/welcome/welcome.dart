import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Montserrat', backgroundColor: Colors.white),
          home: Scaffold(
            body: SafeArea(
                child: Column(
              children: <Widget>[
                const Text('Deliver features faster'),
                const Text('Craft beautiful UIs'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                  child: const Text('TextButton'),
                ),
              ],
            )),
          ),
        ));
  }
  
}
