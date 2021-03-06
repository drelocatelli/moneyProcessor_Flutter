import 'package:flutter/material.dart';
import 'package:moneyapp/Service/TransactionService.dart';
import 'package:moneyapp/Service/UserService.dart';

import '../view/Login.dart';

class Header extends StatefulWidget {
  const Header({Key? key, required this.saldo, required this.carregarSaldo}) : super(key: key);

  final VoidCallback carregarSaldo;

  final String saldo;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

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
              child: Text("Olá, ${UserService.getUserLoggedIn("nome")}",
                  style: TextStyle(fontSize: 22, color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("Saldo: ${widget.saldo}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
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
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36)),
            ),
          ),
          _headerContent(),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.carregarSaldo();
  }

  @override
  Widget build(BuildContext context) {
    return _header();
  }
}
