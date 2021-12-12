import 'package:moneyapp/Security/DBConnection.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  static String _webservice = "${DBConnection.dbHost}/rest/v1/users";

  // dados usuario
  static bool emailExiste = false;

  static List _userLoggedIn = [];

  static Map<String, String> _headers = {
    'Content-type': 'application/json',
    'apiKey': '${DBConnection.secret}',
    'Authorization': 'Bearer: ${DBConnection.JWT}'
  };

  //----------------------

  static _setUserLoggedIn(List user) async {
    _userLoggedIn = user;
    _saveSession();
  }

  static getUserLoggedIn(String what) {
    return _userLoggedIn[0][what];
  }

  static Future<String> getSession(String what) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getString(what));
  }

  static void _saveSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("nome", _userLoggedIn[0]["nome"]);
    prefs.setString("email", _userLoggedIn[0]["email"]);
    prefs.setString("senha", _userLoggedIn[0]["senha"]);
  }

  static void clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool> checksession() async {
    String email = await getSession("email");
    String senha = await getSession("senha");
    if(await login(email, senha)) {
      return true;
    }
    return false;
  }

  static Future<String> getUserIdByEmail() async {

    try {
      final response = await http.get(Uri.parse("${_webservice}?email=eq.${getUserLoggedIn("email")}&select=id"), headers: _headers);

      var id;

      id = json.decode(response.body);

      return id[0]["id"].toString();

    } catch(err) {
      return "error";
    }

  }

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

        _setUserLoggedIn(json.decode(response.body));
        return true;

    } catch(err) {
      return false;
    }

  }

  static Future<bool> cadastro(String nome, String email, String senha) async {

      final params = json.encode({"nome": "${nome}", "email": "${email}", "senha": "${senha}"});

      final request = await http.post(Uri.parse(_webservice), headers: _headers, body: params);

      if(request.statusCode == 201) {
        return true;
      } else {
        return false;
      }

  }


}