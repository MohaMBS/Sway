import 'dart:js';

import 'package:flutter/material.dart';
import 'package:sway_app/bloc/formBloc.dart';
import 'package:sway_app/bloc/formProvider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberButton = true;

  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = FromProvider.of(context);
    return  MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 230.0, left: 50.0, right: 50.0),
              height: 550.0,
              child: Form(child:Column(
                children: <Widget>[
                  _emailField(formBloc),
                  _passwordField(formBloc),
                  SizedBox(
                    width: 300,
                    height: 35,
                    child:Helper.errorMessage(formBloc),
                  ),
                  _keepMeLogin(),
                  _button(formBloc),
                  _forgotPassword(context),
                ],
              )),
            ),
          )),
      ),
    );
  }

  Widget _emailField(FormBloc formBloc) {
    return StreamBuilder<String>(
      stream: formBloc.email,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'escriba@email.com',
            labelText: 'Email',
            errorText: snapshot.error?.toString()
          ),
          onChanged: formBloc.changeEmail,
        );
      }
    );
  }

  Widget _passwordField(FormBloc formBloc) {
    return StreamBuilder<String>(
      stream: formBloc.password,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Contraseña...',
            labelText: 'Contraseña',
            errorText: snapshot.error?.toString(),
          ),
          onChanged: formBloc.changePassword,
        );
      }
    );
  }

  Widget _keepMeLogin(){
    return Row(
          children: <Widget>[
            Checkbox(
              value: rememberButton, 
              onChanged: (checked) => setState(() {
                rememberButton = !rememberButton;
              }),
              ),
              const Text('Mantener la session.')
          ],
    );
  }

  Widget _button(FormBloc formBloc){
    return StreamBuilder<bool>(
      stream: formBloc.submitValidForm,
      builder: (context, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all( Colors.teal[100]),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.blue.withOpacity(0.04);
                            }
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed)) {
                              return Colors.blue.withOpacity(0.12);
                            }
                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      onPressed: (){
                        if(snapshot.hasError){
                          return;
                        }
                        formBloc.login(context);
                      },
                      child:const Text('Login', style: TextStyle(color: Colors.black),)
                  ),
              ),
          ]
        );
      }
    );
  }

  Widget _forgotPassword(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:<Widget> [
        GestureDetector(
          onTap:() => Navigator.pushNamed(context, '/reset_password'),
          child: Container(
            child: const Text('He olvidad la contraseña.'),
            alignment: Alignment.bottomLeft,
          ),
        ),
        GestureDetector(
          onTap:() => Navigator.pushNamed(context, '/register'),
          child: Container(
            child: const Text('Registrate.'),
            alignment: Alignment.bottomLeft,
          ),
        ),
      ],
    );
  }
}

class Helper {
  static Widget errorMessage(FormBloc bloc){
    return StreamBuilder(
      stream: bloc.msgError,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Text(snapshot.data.toString(), style: TextStyle(color: Colors.red),);
        }
        return const Text('');
      }
    );
  }
}
