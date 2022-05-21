import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sway_app/auth/auth.dart';
import 'package:sway_app/auth/userAuth.dart';
import 'package:sway_app/dao/contact.dart';


class HomeDas extends StatefulWidget {
  const HomeDas({ Key? key }) : super(key: key);

  @override
  State<HomeDas> createState() => _HomeDasState();
}

class _HomeDasState extends State<HomeDas> {

  var misContact =<Contact>[];
  

  @override
  void initState() {
    super.initState();
    //contacts.add(ContactField(name:' c.name,idContact', userId:0,idContact: 0,));
    getContact();
  }


  getContact() async{
    print('llamado a pi de contactos');
    await ContactApi().getContacts().then((response){
      Map<String, dynamic> map = json.decode(response.body);
      Map<String, dynamic>  data = map["data"];
      //misContact = data.map((model) => Contact.formJson(model)).toList();
      for (var item in data['connecteds']) {
        Contact c = Contact.formJson(item);
        //contacts.add(ContactField(name:' c.name,idContact', userId:0,idContact: 0,));
        misContact.add(c);
      }
    });
    print('api a acabao');
    return ;
  }

/*
  List<Widget> getContatsR(){
    print('solo 1');
    return misContact;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getContact(),
            builder: (context,snapshot){
              return Column(
                children:[
                  misContact.isEmpty? Text('No hay'): Column(
                    children: misContact.map((e){
                      return Text('data');
                    }).toList(),
                  )
                ],
              );
            }
          ),
        ),
      )
    );
  }

  Container getCartContat(){
    return Container(
      width: MediaQuery.of(context).size.width * 10,
      height: 200,
      decoration: const BoxDecoration(
        color: Color(0xFFEEEEEE),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children:[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration:const BoxDecoration(
                color: Color(0xFFEEEEEE),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.15,
                    height: 50,
                    decoration:const BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    child:const Icon(
                      Icons.account_circle_rounded,
                      color: Colors.black,
                      size: 45,
                    ),
                  ),
                  Container(
                    width:
                        MediaQuery.of(context).size.width * 0.7,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          UserAuth.e().name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.15,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    child:  IconButton(
                      icon:const Icon(Icons.block),
                      color: Colors.red,
                      iconSize: 35, 
                      onPressed: () {  },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactField extends StatelessWidget {
  late final String name;
  late final int idContact,userId;
  ContactField({
    Key? key,
    required String name, required int idContact, required int userId
  }) : super(key: key){
    name = name;
    idContact = idContact;
    userId = userId;
  }

  @override
  Widget build(BuildContext context) {
    return 
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration:const BoxDecoration(
                color: Color(0xFFEEEEEE),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.15,
                    height: 50,
                    decoration:const BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    child:const Icon(
                      Icons.account_circle_rounded,
                      color: Colors.black,
                      size: 45,
                    ),
                  ),
                  Container(
                    width:
                        MediaQuery.of(context).size.width * 0.7,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          UserAuth.e().name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.15,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    child:  IconButton(
                      icon:const Icon(Icons.block),
                      color: Colors.red,
                      iconSize: 35, 
                      onPressed: () {  },
                    ),
                  ),
                ],
              ),
            );
  }
}