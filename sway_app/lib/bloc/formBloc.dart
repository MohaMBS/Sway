import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sway_app/bloc/services/authService.dart';

import './validationMixin.dart';
import 'package:rxdart/rxdart.dart';

class FormBloc with ValidationMixin {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _msgError = BehaviorSubject<String>();

  // getters
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeMsgError => _msgError.sink.add;
  // streams
  Stream<String> get email => _email.stream.transform(validatorEmail);
  Stream<String> get password => _password.stream.transform(validatorPassword);
  Stream<String> get msgError => _msgError.stream;

  Stream<bool> get submitValidForm =>
      Rx.combineLatest3(email, password,msgError, (e, p, er) => true);

  // submitn button
  dynamic register(BuildContext context) async{
    AuthService authInfo = AuthService();
    
    final res =  await authInfo.register(_email.value,_password.value);
    final data = jsonEncode(res) as Map<String, dynamic>;

    if (data['status'] != 200){
      changeMsgError(data['error']);
    }else{
      changeMsgError('');
      AuthService.setToken(data['token'], data['refreshToken']);
      Navigator.pushNamed(context, '/dashboard');
    }
  }
  // submitn button
  dynamic login(BuildContext context) async{
    AuthService authInfo = AuthService();
    
    final res =  await authInfo.login(_email.value,_password.value);
    final data = jsonEncode(res) as Map<String, dynamic>;

    if (data['status'] != 200){
      changeMsgError(data['error']);
    }else{
      changeMsgError('');
      AuthService.setToken(data['token'], data['refreshToken']);
      Navigator.pushNamed(context, '/dashboard');
    }
  }

  dispose() {
    _email.close();
    _password.close();
    _msgError.close();
  }
}