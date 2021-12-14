import 'package:flutter/material.dart';
import 'package:moneyapp/Service/TransactionService.dart';
import 'package:moneyapp/model/Tudo.dart';
import 'package:moneyapp/model/TudoLista.dart';

class Lista extends StatefulWidget {
  const Lista({Key? key, required this.listaItens, required this.atualizaLista, required this.atualizaSaldo}) : super(key: key);

  final VoidCallback atualizaSaldo;
  final VoidCallback atualizaLista;

  final List<Tudo> listaItens;

  @override
  State<StatefulWidget> createState() {
    return ListaState();
  }

}

class ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {

    RegExp dateRegex = RegExp(r"(\d){4}-(\d){2}-(\d){2}");

    final List<Tudo> listaItens = widget.listaItens;

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
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Deletar transação"),
                      content: Text("Tem certeza que deseja deletar a transação '${listaItens[index].title}'?"),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.of(context).pop();
                        },
                            child: Text("Cancelar")
                        ),
                        TextButton(onPressed: () async {
                          await TransactionService.removeById(listaItens[index].id);
                          widget.atualizaSaldo();
                          widget.atualizaLista();
                          Navigator.of(context).pop();
                        },
                            child: Text("Confirmar")
                        )
                      ],
                    )
                );
              },
            )
          );
        }
    );
  }
}
