import 'package:moneyapp/Security/DBConnection.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UserService {

  static String _webservice = "${DBConnection.dbHost}/rest/v1/users";

  // dados usuario
  static bool emailExiste = false;

  static List _userLoggedIn = [];

  static List getUserLoggedIn() {
    return _userLoggedIn;
  }

  static setUserLoggedIn(List user) {
    _userLoggedIn = user;
  }

  static Map<String, String> _headers = {
    'Content-type': 'application/json',
    'apiKey': '${DBConnection.secret}',
    'Authorization': 'Bearer: ${DBConnection.JWT}'
  };

  static Future<bool> emailExists(String email) async {

    try {
      final request = await http.get(Uri.parse("${_webservice}?select=email&email=eq.${email}"), headers: _headers);

      if(!request.body.toString().contains(email)) {
        return false;
      }else {
        return true;
      }
    } catch (err) {
      return false;
    }

  }

  static Future<bool> login(String email, String senha) async {

    try {
      final response = await http.get(Uri.parse("${_webservice}?email=eq.${email}&senha=eq.${senha}"), headers: _headers);

      setUserLoggedIn(json.decode(response.body));

      if(getUserLoggedIn().length != 0) {
        return true;
      }

      return false;
    } catch(err) {
      return false;
    }

  }


}