import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sway_app/auth/auth.dart';
import 'package:sway_app/auth/userAuth.dart';
import 'package:sway_app/dao/contact.dart';

class HomeDas extends StatefulWidget {
  const HomeDas({Key? key}) : super(key: key);

  @override
  State<HomeDas> createState() => _HomeDasState();
}

class _HomeDasState extends State<HomeDas> {
  var misContact = <Widget>[];
  var contacts = <Contact>[];
  var resquestFriend = <Contact>[];
  late bool statAlert = false;

  @override
  void initState() {
    super.initState();
    //contacts.add(ContactField(name:' c.name,idContact', userId:0,idContact: 0,));
  }

  getContact() async {
    contacts.clear();
    if (statAlert == false) {
      await ContactApi().getContacts().then((response) {
        Map<String, dynamic> map = json.decode(response.body);
        Map<String, dynamic> data = map["data"];
        //misContact = data.map((model) => Contact.formJson(model)).toList();
        for (var item in data['connecteds']) {
          print('Contactos');
          Contact c = Contact.formJson(item);
          /*misContact.add(ContactField(
            name: c.name,
            userId: c.userId,
            idContact: c.contactId,
            cont: context,
          ));*/
          contacts.add(c);
        }
      });
    }
    return contacts;
  }

  getRequesF() async {
    if (statAlert == false) {
      await ContactApi().getContacts().then((response) {
        Map<String, dynamic> map = json.decode(response.body);
        Map<String, dynamic> data = map["data"];
        for (var item in data['waitng_connection']) {
          print('peticioens');
          Contact c = Contact.formJson(item);
          resquestFriend.add(c);
        }
      });
    }
  }

  getCon() async {
    await getContact();
    return misContact;
  }

  getFriendRequest() async {
    await getRequesF();
    return resquestFriend;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Contactos',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              SizedBox(
                width: 100,
                height: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 10,
                      height: 200,
                      child: SingleChildScrollView(
                        child: FutureBuilder(
                            future: getContact(),
                            builder: (context, snapshot) {
                              return Column(
                                children: [
                                  contacts.isEmpty
                                      ? SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                          child: const Center(
                                              child: Text(
                                            'No tienes contactos añade.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 35),
                                            textAlign: TextAlign.center,
                                          )),
                                        )
                                      : Column(
                                          children: contacts.map((e) {
                                            return Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFEEEEEE),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    height: 50,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xFFEEEEEE),
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .account_circle_rounded,
                                                      color: Colors.black,
                                                      size: 45,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    height: 50,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xFFEEEEEE),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          e.name,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 20),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    height: 50,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xFFEEEEEE),
                                                    ),
                                                    child: IconButton(
                                                      icon: const Icon(
                                                          Icons.block),
                                                      color: Colors.red,
                                                      iconSize: 35,
                                                      onPressed: () async {
                                                        await showMyDialog(
                                                            e.name);
                                                        if (statAlert) {
                                                          detelContact(
                                                              e.userId);
                                                          setState(() {
                                                            getContact();
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                ],
                              );
                            }),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Row(children: [
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                        ),
                        const Text('Añadir contacto')
                      ]),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Peticiones de amistades',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: FutureBuilder(
                            future: getFriendRequest(),
                            builder: ((context, snapshot) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  resquestFriend.isEmpty
                                      ? const Center(
                                        child:  Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child:  Text('No tienes solicitudes', textAlign: TextAlign.center, style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                                        ),
                                      )
                                      : Column(
                                          children: resquestFriend.map((e) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFEEEEEE),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xFFEEEEEE),
                                                  ),
                                                  child: const Icon(
                                                    FontAwesomeIcons.userSecret,
                                                    color: Colors.black,
                                                    size: 24,
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xFFEEEEEE),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children:  [
                                                      Text(
                                                        e.name,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xFFEEEEEE),
                                                  ),
                                                  child: IconButton(
                                                    icon: const Icon(Icons.check),
                                                    color: Colors.green,
                                                    iconSize: 24,
                                                    onPressed:() async{
                                                      print('id contac'+e.contactId.toString());
                                                      await accpetRequest(e.contactId);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList()),
                                ],
                              );
                            })),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  detelContact(int userId) async {
    ResponseStatus res = await ContactApi().deleteContact(userId.toString());
    if (res.status) {
      contacts.removeWhere((element) => element.userId == userId);
      setState(() {
        getCon();
      });
    }
  }

  accpetRequest(int contactId) async{
    ResponseStatus res = await ContactApi().accpetRequest(contactId.toString());
    if(res.status){
      resquestFriend.removeWhere((element) => element.contactId == contactId);
      setState(() {
        misContact.clear();
      });
    }
  }

  Future<void> showMyDialog(String name) async {
    statAlert = false;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Borrar contacto'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Seguro de que quieres borrar el contacto? Llamado: ' +
                    name),
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
}

class ContactField extends StatelessWidget {
  final String name;
  final int idContact, userId;
  bool statAlert = false;
  late final BuildContext cont;
  ContactField(
      {Key? key,
      required this.name,
      required this.idContact,
      required this.userId,
      required this.cont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: const BoxDecoration(
        color: Color(0xFFEEEEEE),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child: const Icon(
              Icons.account_circle_rounded,
              color: Colors.black,
              size: 45,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child: IconButton(
              icon: const Icon(Icons.block),
              color: Colors.red,
              iconSize: 35,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
