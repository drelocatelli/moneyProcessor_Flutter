import 'package:moneyapp/Service/TransactionService.dart';

import 'Tudo.dart';

class TudoLista {

  static Future<List<Tudo>> atualizaLista() async {
    return await TransactionService.atualizaTudo();
  }

  static Future<List<Tudo>> lista([String? date]) async {
    return await TransactionService.atualizaTudo(date ?? null);
  }


}