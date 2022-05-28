import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:http/http.dart';
import 'package:sway_app/auth/auth.dart';
import 'dart:io';

import 'package:sway_app/dao/loan.dart';

class CreateLoan extends StatefulWidget {
  const CreateLoan({Key? key}) : super(key: key);

  @override
  State<CreateLoan> createState() => _CreateLoanState();
}

class _CreateLoanState extends State<CreateLoan> {
  late int conditionTypeValue=0;
  late int loanTypeValue=0;
  late int userId=0;
  late int typeLoanValue;
  late bool switchListTileValue = false;
  late String conditonDescValue='';

  late TextEditingController penaltyDescrController;
  late TextEditingController descriptionLoanController;
  late TextEditingController inputConceptController;
  late TextEditingController limitDateLoanController;
  late TextEditingController conditonDesc;


  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final DateTime now = DateTime.now();
  late File file;
  bool start = true;
  List<DropdownMenuItem<int>> contacts = [DropdownMenuItem<int>(value: 0, child: Container( child:const Text("Seleccione un contacto.")))];
  List<DropdownMenuItem<int>> loanType = [DropdownMenuItem<int>(value: 0, child: Container( child:const Text("Seleccione un tipo.")))];
  List<DropdownMenuItem<int>> coditonType = [DropdownMenuItem<int>(value: 0, child: Container( child:const Text("Seleccione una condicion.")))];

  getPrepare() async {
    Response res = await LoanApi().getPreparation();
    print(res);
    
    List<DropdownMenuItem<int>> tempCon = [];
    List<DropdownMenuItem<int>> tempLoan = [];
    List<DropdownMenuItem<int>> tempCondi = [];

    if (res.statusCode == 200) {
      print(res.body);
      Map<String, dynamic> map = json.decode(res.body);
      Map<String, dynamic> data = map["data"];
      if(start){
        for (var item in data["contacts"]) {
          var va =DropdownMenuItem<int>(value: item['id'], child: Container(child: Text(item['name'])));
          tempCon.add(va);
        }
        for (var item in data["condition_type"]) {
          if(item['description'] != null){
            tempLoan.add(DropdownMenuItem<int>(value: item['id'], child: Container(child: Text(item['description'].toString()))));
          }
        }
        for (var item in data["loan_type"]) {
          if(item['description'] != null){
            tempCondi.add(DropdownMenuItem<int>(value: item['id'], child: Container(child: Text(item['description'].toString()))));
          }
        }
      }
      start = false;
    }
    contacts.addAll(tempCon.toSet().toList());
    loanType.addAll(tempLoan.toSet().toList());
    coditonType.addAll(tempCondi.toSet().toList());
    return contacts;
  }

  @override
  void initState() {
    super.initState();
    descriptionLoanController = TextEditingController();
    inputConceptController = TextEditingController();
    limitDateLoanController = TextEditingController();
    penaltyDescrController = TextEditingController();
    conditonDesc = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPrepare(),
        builder: (context, snapshot) {
           if(snapshot.hasData)
          {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 75, 192, 212),
              automaticallyImplyLeading: false,
              title: const Text(
                'Crear un prestamo',
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                DropdownButtonFormField<int>(
                                  isExpanded: true,
                                  hint:
                                      const Text('Seleccione a un contacto...'),
                                  value: userId,
                                  icon: const Icon(Icons.list),
                                  elevation: 16,
                                  validator: (value) => value == 0 ? 'Debe de escoger a un usuario si no aparecen usuarios, agrege primero.' : null,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  onTap: (){
                                  },
                                  onChanged: (value){
                                    print(value);
                                        userId =value!;
                                    },
                                  items: contacts
                                ),
                                TextFormField(
                                  controller: inputConceptController,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    'inputConceptController',
                                    const Duration(milliseconds: 2000),
                                    () => setState(() {}),
                                  ),
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Concepto *',
                                    hintText:
                                        'Escriba aquí el titulo del prstamo...',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(0, 255, 255, 255),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.title_outlined,
                                    ),
                                  ),
                                  style: const TextStyle(),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Necesita escribir el concepto para poder crear el prestamo...';
                                    }
                                    if (val.length < 5) {
                                      return 'Requires at least 5 characters.';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: limitDateLoanController,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    'limitDateLoanController',
                                    const Duration(milliseconds: 2000),
                                    () => setState(() {}),
                                  ),
                                  autofocus: true,
                                  obscureText: false,
                                  validator: (value)=> value!.isEmpty ? 'Ponga una fecha':null,
                                  decoration: InputDecoration(
                                    labelText: 'Fecha de entrega *',
                                    hintText: now.day.toString()+'-'+now.month.toString()+'-'+now.year.toString(),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.date_range,
                                    ),
                                  ),
                                  style: const TextStyle(),
                                  keyboardType: TextInputType.datetime,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Expanded(
                                        child: Text('Tipo de prestamo *',
                                            textAlign: TextAlign.center,
                                            style: TextStyle()),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.75,
                                        child: DropdownButtonFormField<int>(
                                          value: loanTypeValue,
                                          icon: const Icon(Icons.list),
                                          isExpanded: true,
                                          elevation: 2,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          validator: (value) => value == 0 ? 'Debe de escoger un tipo de prestamo.' : null,
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              loanTypeValue = newValue! ;
                                            });
                                          },
                                          items: loanType,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text('Descrición del prestamo *', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 5, 0, 5),
                                        child: TextFormField(
                                          controller: descriptionLoanController,
                                          onChanged: (_) => EasyDebounce.debounce(
                                            'descriptionLoanController',
                                            const Duration(milliseconds: 2000),
                                            () => setState(() {}),
                                          ),
                                          validator: (value) => value!.isEmpty || value.length < 5? 'Debe de escribir una descripción max extensa': null,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: const InputDecoration(
                                            hintText:
                                                'Escriba la descripción para el prestamo....',
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: const TextStyle(),
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Condición prestamo *',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.75,
                                        child: DropdownButtonFormField <int>(
                                          value: conditionTypeValue,
                                          isExpanded: true,
                                          icon: const Icon(Icons.list),
                                          elevation: 2,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          validator: (value) => value == 0 ? 'Debe de escoger una condición.' : null,
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              conditionTypeValue = newValue!;
                                            });
                                          },
                                          items: coditonType,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text('Descrición de la condicion *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 5, 0, 5),
                                        child: TextFormField(
                                          validator: (value) => value!.isEmpty || value.length < 5? 'Debe de escribir una descripción max extensa': null,
                                          controller: conditonDesc,
                                          onChanged: (_v) => EasyDebounce.debounce(
                                            'descriptionLoanController',
                                            const Duration(milliseconds: 2000),
                                            () => (() {
                                              conditonDescValue = _v;
                                              
                                              print(conditonDescValue);
                                              }),
                                          ),
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: const InputDecoration(
                                            hintText:
                                                'Escriba la descripción para el prestamo....',
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: const TextStyle(),
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Text(
                                      'Documento',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: 50,
                                      child: TextButton(
                                          onPressed: () async {
                                            var picked = await FilePicker
                                                .platform
                                                .pickFiles(
                                              type: FileType.custom,
                                              allowedExtensions: [
                                                'png',
                                                'jpeg',
                                                'doc',
                                                'docx',
                                                'pdf',
                                                'txt'
                                              ],
                                            );
                                            if (picked != null) {
                                              print(picked.files.first.name);
                                              file = File(picked
                                                  .files.single.path
                                                  .toString());
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text('Subir archivo de prueba.'),
                                              Icon(Icons.upload)
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Los formatos validos son los siguientes: png,jpeg,doc,docx,pdf,txt',
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ),
                                SwitchListTile(
                                  value: switchListTileValue,
                                  onChanged: (newValue) => setState(
                                      () => switchListTileValue = newValue),
                                  title: const Text(
                                    'Tiene castigo',
                                    style: TextStyle(),
                                  ),
                                  subtitle: const Text(
                                    'Marca esta opcion para hacer un castigo',
                                    style: TextStyle(),
                                  ),
                                  tileColor: const Color(0xFFF5F5F5),
                                  dense: false,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                ),
                                Visibility(
                                  visible:switchListTileValue ,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFEEEEEE),
                                    ),
                                    child: Visibility(
                                      visible: true,
                                      child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 5, 0, 5),
                                        child: TextFormField(
                                          controller: penaltyDescrController,
                                          onChanged: (_) => EasyDebounce.debounce(
                                            'penaltyDescrController',
                                            const Duration(milliseconds: 2000),
                                            () => setState(() {}),
                                          ),
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: const InputDecoration(
                                            hintText:
                                                'Escriba la descripción para del castigo....',
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: const TextStyle(),
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.35),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.save,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          onPressed: () async {
                                            print(formKey.currentState!.validate());
                                            if (formKey.currentState!.validate()) {
                                              ResponseStatus res = await LoanApi().postLoan(userId,inputConceptController.text.toString(),descriptionLoanController.text.toString(),
                                              loanTypeValue,limitDateLoanController.text.toString(),conditionTypeValue,conditonDesc.text.toString(),file);
                                              print(res.status);
                                              if(res.status){
                                                Navigator.of(context).pop();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Creado, solo hace falta esperar a que acpete.')),
                                                );
                                              }else{
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Fallo al intentar crear el prestamo 😅, intentelo mas tarde.')),
                                                );
                                              }
                                            }
                                            print('IconButton pressed ...');
                                          },
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon:
                                                const Icon(Icons.cancel_outlined))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          }else{
            return const Scaffold(
                  body: Center(
                    child: Text('Loading...'),
                  ),
                );
          }
        });
        
  }
}
