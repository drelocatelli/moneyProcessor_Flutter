import 'package:flutter/material.dart';

class Despesa extends StatefulWidget {
  const Despesa({Key? key}) : super(key: key);

  @override
  _DespesaState createState() => _DespesaState();
}

class _DespesaState extends State<Despesa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        shadowColor: Colors.transparent,
        title: Text("Adicionar despesa"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.only(top: 20, right: 10),
              color: Colors.red,
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
