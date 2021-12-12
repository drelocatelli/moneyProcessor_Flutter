import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Receita extends StatefulWidget {
  const Receita({Key? key}) : super(key: key);

  @override
  _ReceitaState createState() => _ReceitaState();
}

class _ReceitaState extends State<Receita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        shadowColor: Colors.transparent,
        title: Text("Adicionar receita"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.only(top: 20, right: 10),
              color: Colors.lightGreen,
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.width,
              child: SizedBox(
                width: 150,
                child: TextField(
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white, fontSize: 28),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 28),
                    hintText: "R\$ 00.00",
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  ),
                ),
              )
          ),
          Container(
            padding: EdgeInsets.only(top: 30, left: 30, right: 30),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.datetime,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "Data (MM/AAAA)"
                  ),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      labelText: "Título"
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Container(),
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text("Adicionar")
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
