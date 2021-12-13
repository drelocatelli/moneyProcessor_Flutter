import 'package:moneyapp/Service/TransactionService.dart';

import '../model/Tudo.dart';

class TudoLista {

  static Future<List<Tudo>> lista([String? date]) async {
    return await TransactionService.atualizaTudo(date ?? null);
  }


}