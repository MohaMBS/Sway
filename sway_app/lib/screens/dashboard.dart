
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sway_app/auth/auth.dart';
import 'package:sway_app/auth/userAuth.dart';
import 'package:sway_app/screens/homedash.dart';
import 'package:sway_app/screens/loancenter.dart';
import 'package:sway_app/screens/login.dart';
import 'package:sway_app/screens/profile.dart';

class DashboardV extends StatelessWidget {
  const DashboardV({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Dashboard();
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 1;
  final userAuth = UserAuth.e(); 
  @override
  Widget build(BuildContext context) {
    final iconosMenus = <Widget>[
      Icon(
        Icons.adjust,
        size: 30,
        color: Colors.green.shade800,
      ),
      Icon(
        Icons.dashboard,
        size: 30,
        color: Colors.green.shade800,
      ),
      Icon(
        Icons.manage_accounts,
        size: 30,
        color: Colors.green.shade800,
      ),
    ];

    final screen = [
      const LoanCenter(),
      const HomeDas(),
      const ProfileSettings(),
    ];

    return MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Montserrat', backgroundColor: Colors.white),
          home: Scaffold(
            appBar: AppBar(
              leading: const BackButton(
                color: Colors.black,
              ),
              actions: [
                InkWell(
                  onTap: () async {
                    Auth().lgout();
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    await preferences.clear();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 5.0),
                    width: 50,
                    child: const Icon(
                      Icons.logout,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Sway',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat-bold',
                    fontSize: 25),
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              animationCurve: Curves.easeInOutCubicEmphasized,
              color: Colors.teal.shade50,
              backgroundColor: Colors.transparent,
              items: iconosMenus,
              height: 60,
              index: index,
              onTap: (index) => setState(() {
                this.index = index;
              }),
            ),
            body: screen[index],
          ),
        ));
  }
}
