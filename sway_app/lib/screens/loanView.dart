import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:sway_app/api/api.dart';
import 'package:sway_app/dao/loan.dart';
import 'package:permission_handler/permission_handler.dart';

class LaonV extends StatefulWidget {
  const LaonV(this.id);

  final String id;

  @override
  _LaonVState createState() => _LaonVState();
}

class _LaonVState extends State<LaonV> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late LoanW l;
  String name = '';
  bool status = false;
  bool statAlert = false;
  var _openResult = 'Unknown';

  getLoan() async {
    http.Response response = await LoanApi().getLoan(widget.id);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);

      l = LoanW.formJson(map['data'][0]);
      //print(map['data'][0]['user_from']['name']);
      if (map['data'][0]['user_from'] != null) {
        name = 'Prestado ara ' + map['data'][0]['user_from']['name'];
      } else {
        name = 'Tomado de ' + map['data'][0]['user_to']?['name'];
      }
      if (map['data'][0]['status']['description'] != 'Accepted') {
        status = true;
      }
      return l;
    }

    return;
  }

  Future<void> openFile(String src) async {
    String? filePath = r'' + src;

    final _result = await OpenFile.open(filePath);
    print(_result.message);

    setState(() {
      _openResult = "type=${_result.type}  message=${_result.message}";
    });
  }

  Future<void> showMyDialog() async {
    statAlert = false;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseas aceptar el prestamo'),
          content: SingleChildScrollView(
            child: ListBody(
              children:const <Widget>[
                Text('Seguro de que quieres aceptar el prestamo'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                statAlert = true;
              },
              style: TextButton.styleFrom(primary: Colors.red),
              icon: const Icon(FontAwesomeIcons.check),
              label: const Text(
                'Continuar',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
                statAlert = false;
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getLoan(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 75, 192, 212),
                automaticallyImplyLeading: false,
                title: const Text(
                  'Ver prestamo',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 5.0),
                      width: 50,
                      child: const Icon(
                        Icons.cancel_rounded,
                        size: 20,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
                centerTitle: false,
                elevation: 2,
              ),
              body: SafeArea(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00EEEEEE),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        l.concepto,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        l.fechaLimite,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(name)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: Container(
                                    width: 100,
                                    height: 150,
                                    decoration: const BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Text(
                                          'Descripcion',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 110,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFEEEEEE),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(l.descripcion),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: Container(
                                    width: 100,
                                    height: 150,
                                    decoration: const BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Text(
                                          'Condicion',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 110,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFEEEEEE),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      l.descripcionCondicion),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: Container(
                                    width: 100,
                                    height: 150,
                                    decoration: const BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Text(
                                          'Castigo',
                                          textAlign: TextAlign.start,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 130,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFEEEEEE),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                l.castigo == ''
                                                    ? const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                            'No contienes castigo.'),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(l.castigo),
                                                      )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: l.documento == '' ||
                                          l.documento == 'null'
                                      ? null
                                      : () async {
                                          Map<Permission, PermissionStatus>
                                              statuses = await [
                                            Permission.storage,
                                            //add more permission to request here.
                                          ].request();
                                          if (statuses[Permission.storage]!
                                              .isGranted) {
                                            var dir =
                                                await DownloadsPathProvider
                                                    .downloadsDirectory;
                                            if (dir != null) {
                                              String savename =
                                                  l.documento.split('/').last;
                                              String savePath =
                                                  dir.path + "/$savename";
                                              print(savePath);
                                              try {
                                                await Dio().download(
                                                    Uri.http(ApiInfo.baseUrl,
                                                            l.documento)
                                                        .toString(),
                                                    savePath, onReceiveProgress:
                                                        (received, total) {
                                                  if (total != -1) {
                                                    print((received /
                                                                total *
                                                                100)
                                                            .toStringAsFixed(
                                                                0) +
                                                        "%");
                                                    //you can build progressbar feature too
                                                  }
                                                });
                                                print(
                                                    "File is saved to download folder.");
                                                openFile(savePath);
                                              } on DioError catch (e) {
                                                print(e.message);
                                              }
                                            }
                                          } else {
                                            print(
                                                "No permission to read and write.");
                                          }
                                        },
                                  icon: const Icon(
                                    // <-- Icon
                                    Icons.download,
                                    size: 24.0,
                                  ),
                                  label: const Text(
                                      'Descargar documento'), // <-- Text
                                ),
                                status
                                    ? ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.orange)),
                                        icon: const Icon(
                                          // <-- Icon
                                          Icons.check,
                                          size: 24.0,
                                        ),
                                        label: const Text('Aceptar prestamo'),
                                        onPressed: () async {
                                          await showMyDialog();
                                          if(statAlert){
                                            http.Response response =  await LoanApi().aceptLaon(l.id);
                                            if(response.statusCode == 200){
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Se ha confirmado.')),
                                              );
                                            }else{
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('No has aceptado el prestamo.')),
                                              );
                                            }
                                          }
                                        },
                                      )
                                    : ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.orange)),
                                        icon: const Icon(
                                          // <-- Icon
                                          Icons.check,
                                          size: 24.0,
                                        ),
                                        label: const Text('Aceptar prestamo'),
                                        onPressed: null,
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
