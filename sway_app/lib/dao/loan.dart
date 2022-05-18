class Loan{
  late int id;
  late String concept;
  late String description;
  late String documentSrc;
  late int userFromId;
  late int userToId;
  late int conditionId;
  late int typeLoanId;
  late int loanStatus;
  late int penaltyId;

  Loan.e();
  Loan(this.id,this.concept,this.description,this.documentSrc,this.userFromId,this.userToId,
  this.conditionId,this.typeLoanId,this.loanStatus,this.penaltyId);

  void fromQuery(){
    print('object');
  }
}