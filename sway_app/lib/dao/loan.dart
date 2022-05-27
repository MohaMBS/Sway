import 'dart:html';

import 'package:sway_app/api/api.dart';

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


  getLoan(String id){

  }

  postLoan(){

  }
}