import 'package:flutter/material.dart';
import 'package:moneyapp/Service/TransactionService.dart';
import 'package:moneyapp/Service/UserService.dart';

import '../view/Login.dart';

class OptionsMenu extends StatefulWidget {
  const OptionsMenu({Key? key, required this.atualizaLista, required this.atualizaSaldo}) : super(key: key);

  final VoidCallback atualizaSaldo;
  final VoidCallback atualizaLista;

  @override
  _OptionsMenuState createState() => _OptionsMenuState();
}

class _OptionsMenuState extends State<OptionsMenu> {

  Widget _optionsMenu() {
    return Padding(
      padding: EdgeInsets.only(right: 5),
      child: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () => {
              widget.atualizaSaldo(),
              widget.atualizaLista(),
            },
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.refresh, color: Colors.black)),
                Text("Atualizar")
              ],
            ),
          ),
          PopupMenuItem(
            onTap: () async {
              UserService.clearSession();
              final navigator = Navigator.of(context);
              await Future.delayed(Duration.zero);
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => Login()), (route) => false,
              );
            },
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.logout, color: Colors.black)),
                Text("Sair")
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _optionsMenu();
  }
}
