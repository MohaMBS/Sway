import '../auth/userAuth.dart';

class ApiInfo{
  static String baseUrl="sway.ies-eugeni.cat:8000";
  static String baseUrlApi="sway.ies-eugeni.cat:8000/api/";
  static String registerUrl="$baseUrl/api/registration";
  static String loginUrl="$baseUrl/api/login";
  static var headers = {"Content-Type": "application/json","Authorization":"Bearer "+UserAuth.e().token};
}