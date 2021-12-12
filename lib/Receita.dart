import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Panel.dart';
import 'Service/TransactionService.dart';

class Receita extends StatefulWidget {
  const Receita({Key? key}) : super(key: key);

  @override
  _ReceitaState createState() => _ReceitaState();
}

class _ReceitaState extends State<Receita> {

  double _value = 0.0;
  String _date = "";
  String _title = "";

  void addReceita() async {
    if(_title.isNotEmpty && _date.isNotEmpty) {

      RegExp regexDate = new RegExp(r"(\d){2}\/(\d){4}");
      bool verifyDate = regexDate.hasMatch(_date);
      if(verifyDate) {
        if(await TransactionService.addReceita(_value, _date, _title)) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Panel() ));
        }else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Ocorreu um erro"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                );
              }
          );
        }
      }else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Formato de data inválido!"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              );
            }
        );
      }
    }else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Verifique campos nulos"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('Tentar novamente'),
                ),
              ],
            );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        shadowColor: Colors.transparent,
        title: Text("Adicionar receita"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.only(top: 20, right: 10),
              color: Colors.lightGreen,
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.width,
              child: SizedBox(
                width: 150,
                child: TextField(
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white, fontSize: 28),
                  onChanged: (text) {
                    _value = double.tryParse(text) ?? 0.0;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 28),
                    hintText: "R\$ 00.00",
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  ),
                ),
              )
          ),
          Container(
            padding: EdgeInsets.only(top: 30, left: 30, right: 30),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.datetime,
                  textAlign: TextAlign.center,
                  onChanged: (text) {
                    _date = text;
                  },
                  decoration: InputDecoration(
                    labelText: "Data (MM/AAAA)"
                  ),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (text) {
                    _title = text;
                  },
                  decoration: InputDecoration(
                      labelText: "Título"
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Container(),
                ),
                ElevatedButton(
                    onPressed: () {
                      addReceita();
                    },
                    child: Text("Adicionar")
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
