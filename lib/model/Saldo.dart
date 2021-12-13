import 'package:moneyapp/Service/TransactionService.dart';

class Saldo {

  static String _saldo = "0.0";

  static String getSaldo(){
  return _saldo;
}

  static setSaldo(String value) {
    _saldo = value;
  }

  static void atualizaSaldo() async {
    await TransactionService.getSaldoValue().then((value) {
        Saldo.setSaldo(value);
    });
  }

}