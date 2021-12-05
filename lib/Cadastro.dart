import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

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
                  children: [
                    TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.supervised_user_circle),
                        labelText: 'Nome',
                      ),
                    ),
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
