import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneyapp/Login.dart';
import 'package:moneyapp/Service/TransactionService.dart';
import 'package:moneyapp/Service/UserService.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Panel extends StatefulWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {

  String _saldo = "0.00";

  void atualizaSaldo() async {
    this._saldo = await TransactionService.getSaldoValue();
  }

  void _deslogar() async {
    print("TODO: Deslogar");
  }

  Widget _header() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Olá, ${UserService.getUserLoggedIn("nome")}", style: TextStyle(fontSize: 22, color: Colors.white)),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("Saldo: R\$ ${_saldo}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
        ),
      ),
    );
  }

  Widget _optionsMenu() {
    return Padding(
        padding: EdgeInsets.only(right: 5),
        child: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () => atualizaSaldo(),
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(right: 5), child: Icon(Icons.refresh, color: Colors.black)),
                  Text("Atualizar")
                ],
              ),
            ),
            PopupMenuItem(
              onTap: () => _deslogar(),
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(right: 5), child: Icon(Icons.logout, color: Colors.black)),
                  Text("Sair")
                ],
              ),
            ),
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context)  {

    atualizaSaldo();

    return Scaffold(
        appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text("Money Processor"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlueAccent,
          actions: [
            this._optionsMenu(),
          ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              color: Color.fromRGBO(240, 240, 240, 1),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  this._header(),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
