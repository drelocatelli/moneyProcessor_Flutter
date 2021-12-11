import 'package:moneyapp/Security/DBConnection.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:moneyapp/Service/UserService.dart';

class TransactionService {

  static String _webservice = "${DBConnection.dbHost}/rest/v1/transaction";
  static List<dynamic> despesas = [];

  static Map<String, String> _headers = {
    'Content-type': 'application/json',
    'apiKey': '${DBConnection.secret}',
    'Authorization': 'Bearer: ${DBConnection.JWT}'
  };

  static Future<String> getSaldoValue() async {

    double despesa = double.parse(await getDespesaTotal());
    double receita = double.parse(await getReceitaTotal());

    double calculo = receita - despesa;

    return calculo.toString();

  }

  static Future<bool> atualizaDespesas() async {
    print(UserService.getUserIdByEmail());
    try {
      final request = await http.get(Uri.parse(
          "${_webservice}?user_id=eq.${await UserService.getUserIdByEmail()}&type=eq.d&select=*"),
          headers: _headers);

      List<dynamic> response = json.decode(request.body);
      despesas = response;

      return true;
    } catch (err) {
      return false;
    }
  }

  static Future<String> getDespesaTotal() async {
    print(UserService.getUserIdByEmail());
    try {
      final request = await http.get(Uri.parse(
          "${_webservice}?user_id=eq.${await UserService.getUserIdByEmail()}&type=eq.d&select=value"),
          headers: _headers);

      List<dynamic> response = json.decode(request.body);

      double sum = 0;

      for(var i = 0; i < response.length; i++) {
        sum += double.parse(response[i]["value"]);
      }

      return sum.toString();
    } catch (err) {
      return "error";
    }
  }

  static Future<String> getReceitaTotal() async {
    print(UserService.getUserIdByEmail());
    try {
      final request = await http.get(Uri.parse(
          "${_webservice}?user_id=eq.${await UserService.getUserIdByEmail()}&type=eq.r&select=value"),
          headers: _headers);

      List<dynamic> response = json.decode(request.body);

      double sum = 0;

      for(var i = 0; i < response.length; i++) {
        sum += double.parse(response[i]["value"]);
      }

      return sum.toString();
    } catch (err) {
      return "error";
    }
  }


}