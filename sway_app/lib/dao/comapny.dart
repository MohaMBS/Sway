class Company{
  late int id;
  late String cif;
  late String fixNumber;
  late String address;
  late String city;
  late String pc;
  late String country;

  Company.e();
  Company(this.id,this.cif,this.fixNumber,this.address,this.city,this.pc,this.country);

  void fromQuery(){
    print('Gello');
  }
}