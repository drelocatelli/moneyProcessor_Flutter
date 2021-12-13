import 'package:flutter/material.dart';
import 'package:moneyapp/Service/TransactionService.dart';
import 'package:moneyapp/model/Tudo.dart';

class Lista extends StatelessWidget {
  const Lista({Key? key, required this.listaItens}) : super(key: key);

  final List<Tudo> listaItens;

  @override
  Widget build(BuildContext context) {

    RegExp dateRegex = RegExp(r"(\d){4}-(\d){2}-(\d){2}");

    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listaItens.length,
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: ListTile(
              title: Text(listaItens[index].title),
              subtitle: Text("Atualização: "+dateRegex.firstMatch(listaItens[index].created_at.toString())!.group(0).toString().split('-').reversed.join('/'),
                  style: TextStyle(fontSize: 12, color: Color.fromRGBO(
                      179, 179, 179, 1.0))),
              trailing: Text("R\$ ${listaItens[index].value}",
                  style: TextStyle(
                      color: (listaItens[index].type == "d"
                          ? Colors.red
                          : Colors.green))),
              onTap: () {
                print("Ola mundo");
              },
            ),
          );
        }
    );
  }
}
