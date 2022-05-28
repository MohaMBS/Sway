import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sway_app/auth/auth.dart';
import 'dart:convert';

import '../api/api.dart';

class Loan{
  late String id;
  late String concept;
  late String description;
  late String document; 
  late String userToId;
  late String conditionId;
  late String typeLoanId;
  late String penaltyId;
  late String limitDate;
  late String penalty;
  late String codition;

  Loan(this.concept,this.description,this.document,this.userToId,this.conditionId,this.typeLoanId,this.penaltyId,this.limitDate);
  Loan.e();
  
}

class LoanW{
  late String id;
  late String concepto;
  late String fechaLimite;
  late String descripcion;
  late String descripcionCondicion;
  late String documento;
  late String castigo='';

  LoanW(this.id,this.concepto,this.fechaLimite,this.descripcion,this.descripcionCondicion,this.documento,this.castigo);

  LoanW.formJson(Map json){
    print(json);
    var c = json['condition'];
    var p = json['penalty'];
    id = json['id'].toString();
    concepto= json['concept'].toString();
    fechaLimite = json['limit_date'].toString();
    descripcion = json['description'].toString();
    descripcionCondicion = c['description'].toString();
    documento = json['document_src'].toString();
    castigo = p == null ? '':p['description'].toString();
  }
}

class LoanApi with ApiInfo{


   getPreparation () async {
    var url = Uri.http(ApiInfo.baseUrl,'/api/loan/prepare',{});
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

  Future<ResponseStatus> postLoan(int userId, String concept, String descriprion, int typeLoanId, String limitDate, int conditionConditionTypeId, String conditionDesc, File? file) async{
    ResponseStatus stat = ResponseStatus('Error',false);
    var request = http.MultipartRequest('POST', Uri.http(ApiInfo.baseUrl,'/api/loan/',
    {'user_to_id':userId.toString(),'concept':concept,
      'description':descriprion,'type_loan_id':typeLoanId.toString(),'limit_date':limitDate,
      'condition_description':conditionDesc,'condition_condition_type_id':conditionConditionTypeId.toString()}));
    
      print(file.toString());
    if(file != null){
      request.files.add(http.MultipartFile(
        'file',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path.split("/").last
      ));
    }
      //request.fields.addAll();
    
    //var url = Uri.http(ApiInfo.baseUrl,'/api/loan',{'user_to_id':''});
    //final response = await http.post(url,headers: ApiInfo.headers);
    request.headers.addAll(ApiInfo.headers);
    var res  = await request.send();
    if(res.statusCode == 200){
      stat.status = true;
    }
    return stat;
  }

  Future<http.Response>  getLoanAll() async {
    var url = Uri.http(ApiInfo.baseUrl,'/api/loan',{});
    final response = await http.get(url,headers: ApiInfo.headers);
    print(response.body);
    return response;
  }

  Future<http.Response> getLoan(String id) async {
    var url = Uri.http(ApiInfo.baseUrl,'/api/loan/index',{'id':id});
    final response = await http.get(url,headers: ApiInfo.headers);
    print(response.body);
    return response;
  }
}