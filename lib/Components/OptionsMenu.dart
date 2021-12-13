import 'package:flutter/material.dart';
import 'package:moneyapp/Service/TransactionService.dart';
import 'package:moneyapp/Service/UserService.dart';

import '../Login.dart';

class OptionsMenu extends StatefulWidget {
  const OptionsMenu({Key? key}) : super(key: key);

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
              navigator.pushReplacement(
                MaterialPageRoute(builder: (_) => Login()),
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _optionsMenu();
  }
}
