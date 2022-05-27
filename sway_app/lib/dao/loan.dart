import 'dart:io';
import 'package:sway_app/api/api.dart';
import 'package:http/http.dart' as http;

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

  getLoan(String id){

  }

  postLoan(){

  }
}