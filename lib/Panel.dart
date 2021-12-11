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

  Widget _headerContent() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.16,
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Olá, ${UserService.getUserLoggedIn("nome")}", style: TextStyle(fontSize: 22, color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("Saldo: R\$ ${_saldo}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.19,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36)),
                ),
          ),
          _headerContent(),
        ],
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

  Widget _listContainer() {
    TransactionService.atualizaTudo();

    return ListView.separated(
        shrinkWrap: true,
        itemCount: TransactionService.tudo.length,
        itemBuilder: (context, index) {
          return Container(
            height: 60,
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${TransactionService.tudo[index]["title"]}"),
                      Text("R\$ ${TransactionService.tudo[index]["value"]}",
                          style: TextStyle(color: (TransactionService.tudo[index]["type"] == "d" ? Colors.red : Colors.green) ))
                    ],
                  ),
                  Text("${TransactionService.tudo[index]["created_at"]}", style: TextStyle(fontSize: 12, color: Colors.grey))
                ],
              ),
            ),
          );
        }, separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  @override
  void initState() {
    super.initState();
    () async {
      bool checkSession = await UserService.checksession();
      if(!checkSession) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login() ));
      }
    }();
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
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  _header(),
                  _listContainer()
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
