import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:moneyapp/Components/Header.dart';
import 'package:moneyapp/Components/ListaTudo.dart';
import 'package:moneyapp/Login.dart';
import 'package:moneyapp/Service/TransactionService.dart';
import 'package:moneyapp/Service/UserService.dart';
import 'package:moneyapp/model/Saldo.dart';
import 'package:moneyapp/model/Tudo.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:table_calendar/table_calendar.dart';

import 'Components/MenuFlutuante.dart';
import 'Components/OptionsMenu.dart';
import 'Components/TudoLista.dart';
import 'Despesa.dart';
import 'Receita.dart';

class Panel extends StatefulWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {

  // void _carregaLista([String? date]) async {
  //   await TransactionService.atualizaTudo(date ?? null);
  // }

  String date = "${DateTime.now().month}/${DateTime.now().year}";

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
                    onChanged: (text) {
                      date = text;
                    },
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
                    onPressed: () {
                      setState(() {

                      });
                      if(regexDate.hasMatch(date)) {
                        TudoLista.lista(date);
                        ListaTudo();
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
      TudoLista.lista();
      Saldo.atualizaSaldo();
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
              OptionsMenu(),
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
                        Header(),
                        _calendario(),
                        Expanded(
                          child: SingleChildScrollView(
                              child: (TransactionService.tudo.length >= 1) ? ListaTudo() : Container()
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
