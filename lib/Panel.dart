import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
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
    await TransactionService.getSaldoValue()
    .then((value) {
      setState(() {
        this._saldo = value;
      });
    });
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
              onTap: () async {
                final navigator = Navigator.of(context);
                await Future.delayed(Duration.zero);
                navigator.push(
                  MaterialPageRoute(builder: (_) => Login()),
                );
              },
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
  void initState() {
    super.initState();
    atualizaSaldo();
  }

  @override
  Widget build(BuildContext context)  {
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
