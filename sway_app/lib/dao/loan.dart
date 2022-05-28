import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/api.dart';

class Loan{
  late String concept;
  late String description;
  late File document; 
  late String userToId;
  late String conditionId;
  late String typeLoanId;
  late String penaltyId;
  late String limitDate;

  Loan(this.concept,this.description,this.document,this.userToId,this.conditionId,this.typeLoanId,this.penaltyId,this.limitDate);
  Loan.e();
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

  postLoan(int userId, String concept, String descriprion, int typeLoanId, String limitDate, int conditionConditionTypeId, String conditionDesc, File? file) async{
    var request = http.MultipartRequest('POST', Uri.http(ApiInfo.baseUrl,'/api/loan/'));
    if(file != null){
      request.files.add(http.MultipartFile(
      'picture',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split("/").last
    ));
    }
      request.fields.addAll({'user_to_id':userId.toString(),'concept':concept,
      'description':descriprion,'type_loan_id':typeLoanId.toString(),'limit_date':limitDate,
      'condition_description':conditionDesc,'condition_condition_type_id':conditionConditionTypeId.toString()});
    
    //var url = Uri.http(ApiInfo.baseUrl,'/api/loan',{'user_to_id':''});
    //final response = await http.post(url,headers: ApiInfo.headers);
    request.headers.addAll(ApiInfo.headers);
    request.send().then((response) {
      print(response.statusCode);
    });
  }

  getLoan(){

  }
}