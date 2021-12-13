import 'package:flutter/material.dart';
import 'package:moneyapp/Service/TransactionService.dart';
import 'package:moneyapp/model/Tudo.dart';
import 'package:moneyapp/Components/TudoLista.dart';

class ListaTudo extends StatefulWidget {
  const ListaTudo({Key? key}) : super(key: key);

  @override
  _ListaTudoState createState() => _ListaTudoState();
}

class _ListaTudoState extends State<ListaTudo> {
  
  Widget _listContainer() {
    RegExp dateRegex = RegExp(r"(\d){4}-(\d){2}-(\d){2}");

    return FutureBuilder<List<Tudo>>(
        future: TudoLista.lista(),
        builder: (context, snapshot) {
          return ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: TransactionService.tudo.length,
              itemBuilder: (context, index) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if(snapshot.hasError) {
                      return Text("Error");
                    }else if(!snapshot.hasData) {
                      return Text("");
                    }
                    final tudo = snapshot.data;
                    // return buildTudo(tudo!);
                    return GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        height: 60,
                        color: Colors.white,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(tudo![index].title),
                                  Text("R\$ ",
                                      style: TextStyle(
                                          color: (snapshot.data?[index].type == "d"
                                              ? Colors.red
                                              : Colors.green)))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                }
              },
              separatorBuilder: (BuildContext context, int index) => const Divider());
        });

  }

  @override
  Widget build(BuildContext context) {
    return _listContainer();
  }
}
