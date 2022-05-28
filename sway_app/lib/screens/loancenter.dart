import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sway_app/dao/contact.dart';
import 'package:sway_app/dao/loan.dart';
import 'package:sway_app/screens/loanView.dart';

import 'addLoan.dart';

class LoanCenter extends StatefulWidget {
  const LoanCenter({Key? key}) : super(key: key);

  @override
  State<LoanCenter> createState() => _LoanCenterState();
}

class _LoanCenterState extends State<LoanCenter> {
  var laons = [];
  var loaneds = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  getLoans() async {
    Response response = await LoanApi().getLoanAll();
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      Map<String, dynamic> data = map["data"];
      for (var item in data['prestado']) {
        print('peticioens');
        LoanW c = LoanW.formJson(item);
        laons.add(c);
      }
      for (var item in data['tomados']) {
        print('peticioens');
        LoanW c = LoanW.formJson(item);
        loaneds.add(c);
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getLoans(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(15, 255, 255, 255),
                                ),
                                child: laons.isEmpty
                                    ? Center(
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 150,
                                            child: const Text(
                                              'No hay prestamos.',
                                              style: TextStyle(fontSize: 30),
                                              textAlign: TextAlign.center,
                                            )),
                                      )
                                    : SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: laons.map((lo) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 10),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 40,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFEEEEEE),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(lo.concepto,
                                                        style: TextStyle()),
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons
                                                            .remove_red_eye_rounded,
                                                        color: Colors.black,
                                                        size: 30,
                                                      ),
                                                      onPressed: () async {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute<
                                                                void>(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                   LaonV(lo.id,),
                                                              fullscreenDialog:
                                                                  true,
                                                            ));
                                                        print(
                                                            'IconButton pressed ...');
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(15, 255, 255, 255),
                                ),
                                child: loaneds.isEmpty
                                    ? Center(
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 150,
                                            child: const Text(
                                              'No has tomado ningun prestamo.',
                                              style: TextStyle(fontSize: 30),
                                              textAlign: TextAlign.center,
                                            )),
                                      )
                                    : SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: loaneds.map((lo) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 10),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 40,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFEEEEEE),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(lo.concepto,
                                                        style: TextStyle()),
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons
                                                            .remove_red_eye_rounded,
                                                        color: Colors.black,
                                                        size: 30,
                                                      ),
                                                      onPressed: () async {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute<
                                                                void>(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                   LaonV(lo.id,),
                                                              fullscreenDialog:
                                                                  true,
                                                            ));
                                                        print(
                                                            'IconButton pressed ...');
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
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
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Loading...'),
              ),
            );
          }
        });
  }
}
