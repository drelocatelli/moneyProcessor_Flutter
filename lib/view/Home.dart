import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneyapp/Service/UserService.dart';
import 'package:moneyapp/view/GettingStarted.dart';

import 'Panel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void _checkSession() async {
    bool checkSession = await UserService.checksession();
    await Future.delayed(Duration(seconds: 3));
    if(checkSession) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Panel() ));
    }else {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => GettingStarted() ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    () async {
      _checkSession();
    }();
  }

  @override
  Widget build(BuildContext context) {

    double spacing = 10;

    return Scaffold(
      backgroundColor: Color.fromRGBO(207, 243, 255, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/logo.png"),
            SizedBox(
              height: spacing,
            ),
            CircularProgressIndicator(),
            SizedBox(
              height: spacing + 10,
            ),
            Text("Bem vindo!", style: TextStyle(fontSize: 26, color: Colors.black)),
            SizedBox(
              height: spacing + 30,
            ),
            Text("By drelocatelli", style: TextStyle(color: Colors.black))
          ],
        ),
      ),
    );
  }
}
