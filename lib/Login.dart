import 'package:flutter/material.dart';
import 'package:moneyapp/Service/UserService.dart';

import 'Service/UserService.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late String _email;
  late String _senha;

  Future<void> _Login() async {

    bool validateForm = this._email.isNotEmpty && this._senha.isNotEmpty;

    bool emailExists = await UserService.emailExists(this._email);

    if(validateForm && emailExists) {
      bool login = await UserService.login(this._email, this._senha);

      if(login) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Sucesso"),
                content: Text("Logado com sucesso!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              );
            }
        );
      }else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Erro"),
                content: Text("Senha incorreta!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              );
            }
        );
      }
    }else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Erro"),
              content: Text("Não foi possível realizar o login"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('Tentar novamente'),
                ),
              ],
            );
          }
      );
    }

  }

  Widget _loginForm() {
    return Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.40,
              decoration: new BoxDecoration(
                color: Color.fromRGBO(246, 245, 247, 1),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            onChanged: (text) {
                              this._email = text;
                            },
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.alternate_email),
                              labelText: 'E-mail',
                            ),
                          ),
                          TextField(
                            onChanged: (text) {
                              this._senha = text;
                            },
                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Senha',
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () => _Login(),
                              child: Text("Entrar")
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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

