import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:moneyapp/Components/Header.dart';
import 'package:moneyapp/Login.dart';
import 'package:moneyapp/Service/TransactionService.dart';
import 'package:moneyapp/Service/UserService.dart';
import 'package:moneyapp/model/Tudo.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:table_calendar/table_calendar.dart';

import 'Components/Lista.dart';
import 'Components/MenuFlutuante.dart';
import 'Components/OptionsMenu.dart';
import 'model/TudoLista.dart';
import 'Despesa.dart';
import 'Receita.dart';

class Panel extends StatefulWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {

  List<Tudo> _lista = [];

  String date = "${DateTime.now().month}/${DateTime.now().year}";
  TextEditingController dateInput = TextEditingController(text: "${DateTime.now().month}/${DateTime.now().year}");

  Widget _calendario() {

    RegExp regexDate = new RegExp(r"(\d){2}\/(\d){4}");

    return Container(
      child: TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Selecione Mês/Ano"),
                content: Container(
                  child: TextField(
                    controller: dateInput,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "MM/AAAA"
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () async {
                      if(regexDate.hasMatch(dateInput.text)) {
                        date = dateInput.text;
                        _lista = await TudoLista.lista(date);
                        setState(() {

                        });
                        Navigator.of(context).pop();
                      }

                    },
                    child: Text("Confirmar"),
                  )
                ],
              )
          );
        },
        child: Text("MÊS ${date}", style: TextStyle(color: Colors.black)),
      ),
    );
  }

  String saldo = "0.00";

  _carregarSaldo() async {
    saldo = await TransactionService.getSaldoValue();
    setState(() {

    });
  }

  @override
    void initState() {
      super.initState();
          () async {
        bool checkSession = await UserService.checksession();
        if (!checkSession) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Login()));
        }
      }();
      _carregarLista();

    }

    void _carregarLista() async {
      _lista = await TudoLista.atualizaLista();
      setState(() {

      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            title: Text("Money Processor"),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.lightBlueAccent,
            actions: [
              OptionsMenu(atualizaLista: _carregarLista),
            ],
          ),
          floatingActionButton: MenuFlutuante(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Header(saldo: saldo, carregarSaldo: _carregarSaldo),
                        _calendario(),
                        Expanded(
                          child: SingleChildScrollView(
                              child: Lista(listaItens: _lista, atualizaLista: _carregarLista, atualizaSaldo: _carregarSaldo,),
                          ),
                        )
                      ],
                    )
                ),
              ),
            ],
          ));
    }
  }
