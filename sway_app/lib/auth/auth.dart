

import 'dart:convert';


import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sway_app/api/api.dart';
import 'package:sway_app/auth/userAuth.dart';

class Auth implements ApiInfo {

  Future<ResponseStatus> login(email,password) async
  {
    try {
      final queryParameters = {
        'email': email,
        'password': password,
      };
      var url = Uri.http(ApiInfo.baseUrl,'/api/login',queryParameters);
      final response = await http.get(url,headers: {"Content-Type": "application/json"});
      if(response.statusCode == 200){
        final prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> user = jsonDecode(response.body);
        final authUser = UserAuth.fromJson(user['data']);
        await prefs.setString('UserAuth', jsonEncode(authUser.toJson()));
        return ResponseStatus('Logged', true);
      }else{
        return ResponseStatus('Algo paso.', false);
    }
    } catch (e) {
      return ResponseStatus('Algo paso.', false);
    }
  }

  Future<ResponseStatus> lgout() async
  {
    try {
      var url = Uri.http(ApiInfo.baseUrl,'/api/logout');
      final response = await http.post(url,headers: {"Content-Type": "application/json","Authorization":"Bearer "+UserAuth.e().token});
      if(response.statusCode == 200){
        await deletePref().then((res){
          if(res){
            return ResponseStatus('Logout done', true);
          }else{
            return ResponseStatus('Not logout', false);
          }
        });
        return ResponseStatus('Not logout', false);
      }else{
        return ResponseStatus('Algo paso.', false);
    }
    } catch (e) {
      return ResponseStatus('Algo paso.', false);
    }
  }

  register(email,password) async
  {
    email = 'test@tetas.com';
    password ='AdminSway22@';

    var url = Uri.parse(ApiInfo.registerUrl);
    var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print(await http.read(Uri.parse('https://example.com/foobar.txt')));
  }

  Future<ResponseStatus> updateUser ({required String name,required String email}) async {
    try {
      final queryParameters = {
        'email': email,
        'name': name,
      };
      var url = Uri.http(ApiInfo.baseUrl,'/api/user/update',queryParameters);
      final response = await http.post(url,headers: {"Content-Type": "application/json","Authorization":"Bearer "+UserAuth.e().token});
      if(response.statusCode == 200){
        final prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> user = jsonDecode(response.body);
        final authUser = UserAuth.fromJson(user['data']);
        await prefs.setString('UserAuth', jsonEncode(authUser.toJson()));
        return ResponseStatus('Actualizado', true);
      }else{
        return ResponseStatus('Algo paso, Intentelo mas tarde.', false);
    }
    } catch (e) {
      return ResponseStatus('Algo paso, asegurate de tener internet.', false);
    }
  }

  savePref(int value, String name, String email, int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", value);
    preferences.setString("name", name);
    preferences.setString("email", email);
    preferences.setString("id", id.toString());
    //preferences.commit();
  }

  Future<bool> deletePref() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}

class ResponseStatus{
  bool status;
  String message;
  bool getStatus(){
    return status;
  }
  String getMsg(){
    return message;
  }
  ResponseStatus(this.message,this.status);
}
