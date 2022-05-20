

import 'dart:convert';


import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sway_app/api/api.dart';
import 'package:sway_app/auth/userAuth.dart';

class  Auth implements ApiInfo {
  Future<ResponseStatus> login(email,password) async
  {
    try {
      final queryParameters = {
        'email': email,
        'password': password,
      };
      var url = Uri.http(ApiInfo.baseUrl,'/api/login',queryParameters);
      // print(url);
      final response = await http.get(url,headers: {"Content-Type": "application/json"});
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      // print(response.statusCode);
      // print(response.body);
      if(response.statusCode == 200){
        final prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> user = jsonDecode(response.body);
        
        final authUser = UserAuth.fromJson(user['data']);
        print(authUser.name);
        await prefs.setString('UserAuth', jsonEncode(authUser.toJson()));
        return ResponseStatus('Logged', true);
      }else{
        return ResponseStatus('Algo paso.', false);
    }
    } catch (e) {
      return ResponseStatus('Algo paso.', false);
    }
    //print(await http.read(Uri.parse('https://example.com/foobar.txt')));
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

  savePref(int value, String name, String email, int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setInt("value", value);
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setString("id", id.toString());
      preferences.commit();

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
