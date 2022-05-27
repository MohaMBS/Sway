import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'dart:io';

class CreateLoan extends StatefulWidget {
  const CreateLoan({Key? key}) : super(key: key);

  @override
  State<CreateLoan> createState() => _CreateLoanState();
}

class _CreateLoanState extends State<CreateLoan> {
  late String conditionTypeValue = 'One';
  late String dropDownValue = '';
  late TextEditingController inputConceptController;
  late TextEditingController limitDateLoanController;
  late String typeLoanValue = 'One';
  late TextEditingController descriptionLoanController;
  late bool switchListTileValue = false;
  late TextEditingController penaltyDescrController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final DateTime now = DateTime.now();
  late File file;
  var items = [
    'One',
    'Two',
    'Tree',
    'For',
    'Five',
  ];

  @override
  void initState() {
    super.initState();
    descriptionLoanController = TextEditingController();
    inputConceptController = TextEditingController();
    limitDateLoanController = TextEditingController();
    penaltyDescrController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text('Seleccione a un contacto...'),
                            value: 'One',
                            icon: const Icon(Icons.list),
                            elevation: 16,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            underline: Container(
                              height: 2,
                              color: const Color.fromARGB(255, 77, 255, 246),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                typeLoanValue = newValue!;
                              });
                            },
                            items: <String>['One', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
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
                              labelText: 'Concepto',
                              hintText: 'Escriba aquí el titulo del prstamo...',
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
                            decoration: InputDecoration(
                              labelText: 'Fecha de entrega',
                              hintText: now.toString(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: Text('Tipo de prestamo',
                                      textAlign: TextAlign.center,
                                      style: TextStyle()),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: DropdownButton<String>(
                                    value: 'One',
                                    icon: const Icon(Icons.list),
                                    elevation: 16,
                                    style:
                                        const TextStyle(color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        typeLoanValue = newValue!;
                                      });
                                    },
                                    items: <String>['One', 'Two', 'Free', 'Four']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Condición prestamos',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: DropdownButton<String>(
                                    
                                    value: 'One',
                                    icon: const Icon(Icons.list),
                                    elevation: 16,
                                    style:
                                        const TextStyle(color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        typeLoanValue = newValue!;
                                      });
                                    },
                                    items: <String>['One', 'Two', 'Free', 'Four']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
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
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 5),
                              child: TextFormField(
                                controller: descriptionLoanController,
                                onChanged: (_) => EasyDebounce.debounce(
                                  'descriptionLoanController',
                                  const Duration(milliseconds: 2000),
                                  () => setState(() {}),
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
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Documento',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 100,
                                height: 50,
                                child: TextButton(
                                  onPressed: ()async {  
                                    var picked = await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['png','jpeg','doc','docx','pdf','txt'],
                                    );
                                    if (picked != null) {
                                      print(picked.files.first.name);
                                      file = File(picked.files.single.path.toString());
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:const [
                                      Text('Subir archivo de prueba.'),
                                      Icon(Icons.upload)
                                    ],
                                  ) ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text('Los formatos validos son los siguientes: png,jpeg,doc,docx,pdf,txt',style: TextStyle(fontSize: 8),),
                          ),
                          SwitchListTile(
                            value: switchListTileValue = false,
                            onChanged: (newValue) =>
                                setState(() => switchListTileValue = newValue),
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
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEEEEEE),
                            ),
                            child: Visibility(
                              visible: !(switchListTileValue),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
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
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.save,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(Icons.cancel_outlined))
                              ],
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
  }
}
