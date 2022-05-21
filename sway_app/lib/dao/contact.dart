import 'dart:convert';

import 'package:sway_app/api/api.dart';
import 'package:sway_app/auth/auth.dart';
import 'package:http/http.dart' as http;

class Contact{
  late int contactId,userId;
  late String name,date;
  Contact(this.userId,this.contactId,this.name,this.date);
  Contact.formJson(Map json){
    List<dynamic> f = json['friend_info'];
    contactId = json['id'];
    userId= json['user_to_id'];
    name = f[0]['name'];
    date = f[0]['created_at'];
  }
}

class ContactApi with ApiInfo{

  getContacts() async {
    var url = Uri.http(ApiInfo.baseUrl,'/api/user/connect',{});
    final response = await http.get(url,headers: ApiInfo.headers);
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

}