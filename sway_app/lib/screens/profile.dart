
import 'package:flutter/material.dart';
import 'package:sway_app/auth/auth.dart';
import 'package:sway_app/auth/userAuth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart';


class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passTextControl = TextEditingController(text: '*********');
  String _passowrd = '*********';
  bool statAlert = false;
  late String _newName;
  late String _newEmail;

  Future<void> _showMyDialog({required String title,required String msg}) async {
    statAlert = false;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
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
              icon:const Icon(FontAwesomeIcons.check), 
              label: const Text('Continuar', style: TextStyle(color: Colors.red),),
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(children:  [
          const Text(
            'Ajustes de cuenta y aplicación.',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize:20),
          ),
          Text("Hola de nuevo "+UserAuth.e().name),
          Expanded(
            flex: 1,
            child: Column( 
              children: [
                 Container(height: 15,),
                 Form(
                  key: _formKey,
                  child: 
                  Column(
                    children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: TextEditingController(text: UserAuth.e().name),
                        decoration: const InputDecoration(
                          label: Text.rich(
                            TextSpan(
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Text(
                                    'Nombre de usuario',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        validator:(value){
                          if(value!.isEmpty ||value.length <= 4 ){
                            return 'Desbes de escrbir un bombre que al menos contega 4 carateres';
                          }
                          _newName = value;
                          return null;
                        }
                        , 
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: TextEditingController(text: UserAuth.e().email),
                        decoration: const InputDecoration(
                          label: Text.rich(
                            TextSpan(
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Text(
                                    'Email',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Escriba algo...";
                          }else if(!isEmail(value)){
                            return "Formato invalido de email";
                          }
                          _newEmail = value;
                          return null;
                        },
                      ),
                    ),
                  ],)
                 ),
                 ElevatedButton.icon(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                      print('Guardar');
                        await _showMyDialog(title:'Estas seguro',msg:'Estas seguro de quere cambiar la informacion de tu cuenta');
                        if(statAlert){
                        Future<ResponseStatus> res = Auth().updateUser(name: _newName, email: _newEmail);
                        res.then((status){ 
                          if(status.status){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(status.message)),
                            );
                            UserAuth.e().email = _newEmail;
                            UserAuth.e().name = _newName;
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(status.message)),
                            );
                          }
                        }
                        );
                      }
                      }
                    },
                    icon: const Icon(Icons.save, size: 25),
                    label: const Text('Gaurdar cambios',style: TextStyle(fontSize: 18),),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(primary: Colors.red, backgroundColor: Colors.yellow[100]),
                    onPressed:null
                      /*if(_formKey.currentState!.validate()){
                        _showMyDialog(title:'Seguro que quieres eliminar tu cuenta',msg:'Una vez aceptado, ya no podras volver a aceder a la cuenta');
                      }*/
                      
                    ,
                    icon: const Icon(Icons.delete, size: 20),
                    label: const Text('Eliminar cuenta',style: TextStyle(fontSize: 18),),
                  ),
                 Container(height: 25,),
                  const Text('App info',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  const SizedBox(
                    height: 150,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(image: AssetImage('assets/images/logos/Logo-border-less.png')),
                    ),
                  ),
                   Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 350,
                      child: SingleChildScrollView( 
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children:  [
                              const Text("Sway es un aplicación desarrollada en Flutter.Sway consiste en una aplicación para amigos/empresas ´mors@s´, la aplicacion consiste en un sistema de registro de prestamos entre usuarios , tanto bienes como objetos la finalidad de la aplicación es que los usuarios sean capaz de recordar lo que han prestado para que al final a lo hora de devolverle el objeto o bien, sea el correcto y que no falta nada.",
                                style: TextStyle(), textAlign: TextAlign.justify,),
                              IconButton(icon: const Icon(FontAwesomeIcons.github, color: Colors.blue,), 
                              onPressed: () async{
                                await launchUrl(Uri.parse('https://github.com/MohaMBS/Sway'));
                              })
                            ],
                          ),
                        ),
                    ),
                    )
              ],),
          )
        ]),
      ),
    );
  }
}
