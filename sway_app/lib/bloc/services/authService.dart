import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class AuthService{
  final baseUrl = 'http://sway.ies-eugeni.cat:8000/api';
  static final SESSION= FlutterSession();

  Future<dynamic> register(String email, String password) async{
    try{
      var res = await http.post(Uri.parse('$baseUrl/register'),body:{
        'email': email,
        'password': password
      });

      return res.body;
    }finally{

    }
  }


  Future<dynamic> login(String email, String password) async{
    try{
      var res = await http.post(Uri.parse('$baseUrl/login'),body:{
        'email': email,
        'password': password
      });

      return res.body;
    }finally{
      
    }
  }
  static Future<Map<String, dynamic>> getToken() async{
    return await SESSION.get('tokens');
  }
  static setToken(String token, String refreshToken) async{
    _AuthData data = _AuthData(token, refreshToken);
    await SESSION.set('tokens',data);
  }
  static removeToken() async{
    await SESSION.prefs.clear();
  }
}

class _AuthData{
  late String token, refreshToken;
  _AuthData(String token, String refreshToken);

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'];
    data['refreshToken'];
    return data;
  }
}