import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

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
  int index = 2;

  @override
  Widget build(BuildContext context) {
    const iconosMenus = <Widget>[
      Icon(
        Icons.contacts_rounded,
        size: 30,
      ),
      Icon(
        Icons.add,
        size: 30,
      ),
      Icon(
        Icons.dashboard,
        size: 30,
      ),
      Icon(
        Icons.usb_rounded,
        size: 30,
      ),
      Icon(
        Icons.settings,
        size: 30,
      )
    ];

    return MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Montserrat', backgroundColor: Colors.white),
          home: Scaffold(
            appBar: AppBar(
              leadingWidth: 100,
              leading: InkWell(
                onTap: () { Navigator.of(context).pop();},
                child: Container(
                  margin: const EdgeInsets.only(right: 5.0),
                  width: 50,
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(right: 5.0),
                    width: 50,
                    child: const Icon(
                      Icons.share,
                      size: 25,
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
              color: Colors.black12,
              backgroundColor: Colors.transparent,
              items: iconosMenus,
              height: 60,
              index: index,
              onTap: (index) => setState(() {
                this.index = index;
              }),
            ),
            body: Center(
              child: Text(
                '$index',
              ),
            ),
          ),
        ));
  }
}
