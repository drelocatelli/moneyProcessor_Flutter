import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneyapp/Login.dart';

import 'Service/UserService.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  late String _nome;
  late String _email;
  late String _senha;

  Future<void> _Cadastro() async {

    bool validateForm = this._nome.isNotEmpty && this._email.isNotEmpty && this._senha.isNotEmpty;

    bool emailExists = await UserService.emailExists(this._email);

    if(validateForm && !emailExists) {

      bool cadastro = await UserService.cadastro(_nome, _email, _senha);

      if(cadastro) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Sucesso"),
                content: Text("Não foi possível cadastrar!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('Fazer login'),
                  ),
                ],
              );
            }
        );
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));

      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Erro"),
                content: Text("Não foi possível cadastrar!"),
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

    } else if(emailExists) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Erro"),
              content: Text("Esse e-mail já foi cadastrado!"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('Tentar novamente'),
                ),
              ],
            );
          }
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Erro"),
              content: Text("Não foi possível cadastrar!"),
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

  Widget _cadastroForm() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: new BoxDecoration(
            color: Color.fromRGBO(246, 245, 247, 1),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextField(
                      onChanged: (text) {
                        this._nome = text;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.supervised_user_circle),
                        labelText: 'Nome',
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (text) {
                        this._email = text;
                      },
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
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Senha',
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () => this._Cadastro(),
                        child: Text("Finalizar")
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
            Padding(padding: EdgeInsets.only(top: 35, bottom: 20), child: Text("Junte-se a nós!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            Image.asset("images/man.png", width: MediaQuery.of(context).size.width * 0.30),
            this._cadastroForm(),
          ],
        ),
      ),
    );
  }
}
