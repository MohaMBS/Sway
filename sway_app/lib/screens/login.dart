import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sway_app/auth/auth.dart';
import 'package:sway_app/auth/userAuth.dart';

import 'package:validators/validators.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> with Auth {
  final _formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: const Image(
                      image: AssetImage(
                          'assets/images/logos/Logo-border-less.png'))),
              const Text(
                '¡Hola de nuevo!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Le damos la bienvenida a Sway',
                style: TextStyle(fontSize: 20),
              ),
              //Email filed

              const SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Escriba un email...';
                        } else if (!isEmail(value.trim())) {
                          return 'Introduzca un email valido...';
                        }
                        _email = value.trim();
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Email'),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //Pasword filed
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Escriba una contraseña...';
                        }
                        _password = value;
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Password'),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  //decoration: BoxDecoration(
                  //  borderRadius: BorderRadius.circular(12),
                  //  color: Colors.teal[200]),
                  child: Center(
                      child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        Future<ResponseStatus> status =
                            Auth().login(_email, _password);
                        status.then((status) {
                          if (status.status) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Session iniciada 😀')),
                            );
                            Navigator.pushNamed(context, '/dashboard');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Credenciales erroenas 😅')),
                            );
                          }
                        });
                      }
                    },
                    child: const SizedBox(
                        width: 250,
                        height: 50,
                        child: Center(
                            child: Text(
                          'Iniciar session',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))),
                  )),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿No estas registrado?',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    ' Registrate',
                    style: TextStyle(
                        color: Colors.blue[700], fontWeight: FontWeight.bold),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
