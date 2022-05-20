import 'package:flutter/cupertino.dart';

class UserAuth {
  static final UserAuth _userAuth = UserAuth._internal();
  late String name;
  late String email;
  late String token;
  late String phone;
  late bool logged;

  factory UserAuth({required String name, required String email,required String token, required String phone,
      bool logged = false}) {
    _userAuth.name = name;
    _userAuth.email = email;
    _userAuth.token = token;
    _userAuth.phone = phone;
    _userAuth.logged = logged;
    return _userAuth;
  }

  UserAuth._internal();

  factory UserAuth.fromJson(dynamic json) {
    //return UserAuth(json['name'], json['email'], json['token'], json['phone'],
    //    logged: true);
    print(json['name']);
    _userAuth.name = json['name'];
    _userAuth.email = json['email'];
    _userAuth.token = json['token'];
    _userAuth.phone = json['phone'];
    _userAuth.logged = true;
    return _userAuth;
  }

  factory UserAuth.e(){
    return _userAuth;
  }

 Map<String, dynamic> toJson() => 
  {
    'name': _userAuth.name,
    'email': _userAuth.email,
    'token': _userAuth.token,
    'phone': _userAuth.phone,
    'logged':_userAuth.logged
  };
}

class MisSingel {
  late int id;

  static final MisSingel _inst = MisSingel._internal();

  MisSingel._internal() {
    // some logic
  }

  factory MisSingel({required int id}) {
    _inst.id = id;
    return _inst;
  }
}

/*import 'package:flutter/cupertino.dart';

class UserAuth {
  late String name;
  late String email;
  late String token;
  late String phone;
  late bool logged;

  static final UserAuth _userAuth = UserAuth._internal();

  UserAuth._internal();

  factory UserAuth({required String name,required String email,required String token,required String phone,
      bool logged = false}) {
    _userAuth.email = name;
    _userAuth.email = email;
    _userAuth.email = token;
    _userAuth.email = phone;
    _userAuth.logged = logged;
    return _userAuth;
  }


  factory UserAuth.fromJson(dynamic json) {
    //return UserAuth(json['name'], json['email'], json['token'], json['phone'],
    //    logged: true);
    print(json['name']);
    _userAuth.email = json['name'];
    _userAuth.email = json['email'];
    _userAuth.email = json['token'];
    _userAuth.email = json['phone'];
    _userAuth.logged = true;
    return _userAuth;
  }

 Map<String, dynamic> toJson() => 
  {
    'name': _userAuth.name,
    'email': _userAuth.email,
    'token': _userAuth.token,
    'phone': _userAuth.phone,
    'logged':_userAuth.logged
  };
}
*/