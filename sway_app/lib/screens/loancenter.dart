import 'package:flutter/material.dart';

import 'addLoan.dart';

class LoanCenter extends StatefulWidget {
  const LoanCenter({Key? key}) : super(key: key);

  @override
  State<LoanCenter> createState() => _LoanCenterState();
}

class _LoanCenterState extends State<LoanCenter> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Prestado',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(15, 255, 255, 255),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                          'CondicionCondicionCondicionCondicion...',
                                          style: TextStyle()),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.remove_red_eye_rounded,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          print('IconButton pressed ...');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        icon: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const CreateLoan(),
                                  fullscreenDialog: true,
                                ));
                          },
                          child: Row(children: const [
                            Icon(Icons.add),
                            Text(
                              'Añade',
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.end,
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Tomado',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'CondicionCondicionCondicionCondicion...',
                                        style: TextStyle(),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.remove_red_eye_rounded,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          print('IconButton pressed ...');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
