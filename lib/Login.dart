import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Widget _loginForm() {
    return Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.40,
            decoration: new BoxDecoration(
              color: Color.fromRGBO(246, 245, 247, 1),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    children: [
                      TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email),
                          labelText: 'E-mail',
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Senha',
                        ),
                      ),
                      ElevatedButton(
                          onPressed: (){},
                          child: Text("Entrar")
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text("Desenvolvido por drelocatelli"),
          ),
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 235, 236, 1),
      appBar: AppBar(
        title: Text("Money Processor"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 35, bottom: 20), child: Text("Entre e faça acontecer!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            Image.asset("images/cofre.png", width: MediaQuery.of(context).size.width * 0.20),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: this._loginForm(),
            ),
          ],
        ),
      ),
    );
  }
}

