import 'package:moneyapp/Security/DBConnection.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:moneyapp/Service/UserService.dart';
import 'package:moneyapp/model/Tudo.dart';

class TransactionService {

  static String _webservice = "${DBConnection.dbHost}/rest/v1/transaction";
  static List<dynamic> despesas = [];
  static List<dynamic> receitas = [];
  static List<Tudo> tudo = [];


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

  static Future<bool> addReceita(double value, String date, String title) async {

    try{

      final params = json.encode({
        "value": "${value}",
        "date": "${date}",
        "title": "${title}",
        "type": "r",
        "user_id": "${await UserService.getUserIdByEmail()}"
      });

      final request = await http.post(Uri.parse(
          "${_webservice}"), headers: _headers, body: params);

      if(request.statusCode == 201) {
        return true;
      }

      return false;
    }catch(err) {
      return false;
    }

  }

  static Future<bool> addDespesa(double value, String date, String title) async {

    try{

      final params = json.encode({
            "value": "${value}",
            "date": "${date}",
            "title": "${title}",
            "type": "d",
            "user_id": "${await UserService.getUserIdByEmail()}"
      });

      final request = await http.post(Uri.parse(
          "${_webservice}"), headers: _headers, body: params);

      if(request.statusCode == 201) {
        return true;
      }

      return false;
    }catch(err) {
      return false;
    }
    
  }

  static Future<bool> removeById(int id) async {
    try{

      final request = await http.delete(Uri.parse(
          "${_webservice}?id=eq.${id}"), headers: _headers);

      return true;
    }catch(err) {
      return false;
    }
  }

  static Future<bool> atualizaReceitas() async {
    try {
      final request = await http.get(Uri.parse(
          "${_webservice}?user_id=eq.${await UserService.getUserIdByEmail()}&type=eq.r&select=*"),
          headers: _headers);

      List<dynamic> response = json.decode(request.body);
      receitas = response;

      return true;
    } catch (err) {
      return false;
    }
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

  static Future<List<Tudo>> atualizaTudo([String? date]) async {
    try {
      final String currentDate = date ?? "${DateTime.now().month}/${DateTime.now().year}";
      final request = await http.get(Uri.parse(
          "${_webservice}?user_id=eq.${await UserService.getUserIdByEmail()}&date=eq.${currentDate}&order=created_at&select=*"),
          headers: _headers);

      var response = json.decode(request.body) as List;
      tudo = response.map((e) => Tudo.fromMap(e)).toList();

      return tudo;
    } catch (err) {
      return [];
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