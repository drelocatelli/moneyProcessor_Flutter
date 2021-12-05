  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneyapp/Cadastro.dart';
import 'package:moneyapp/Login.dart';
  import 'model/Slide.dart';


  class GettingStarted extends StatefulWidget {
    const GettingStarted({Key? key}) : super(key: key);

    @override
    _GettingStartedState createState() => _GettingStartedState();
  }

  class _GettingStartedState extends State<GettingStarted> {

    Color corFundo = Colors.lightBlueAccent;

    Widget _slidePage(index) {
      index += 1;
      if(index < 5) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Página ${(index).toString()} / ${Slide.slideList.length - 1}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
            ]);
      }

      return Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange),
                onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro() )),
                child: Text("Cadastre-se"),
            ),
            TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Login() )),
                child: Text("Já possuo cadastro", style: TextStyle(color: Colors.white))
            ),
          ],
      );

    }

    Widget _slide() {

      return PageView.builder(
        itemCount: Slide.slideList.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("${Slide.slideList[index].imageUrl}", width: MediaQuery.of(context).size.width * 0.65),
              Padding(
                  padding: EdgeInsets.only(top:20),
                  child: Text("${Slide.slideList[index].title}", style: TextStyle(color: Colors.white, fontSize: 16))
              ),
              Padding(
                padding: EdgeInsets.only(top:5, bottom: 30),
                child: Text("${Slide.slideList[index].description}", style: TextStyle(color: Colors.white))
                ,
              ),
              this._slidePage(index),
            ],
          );
        },
        onPageChanged: (i){
          setState(() {
            corFundo = Slide.colors[i]["color"] as Color;
          });
        },
      );


    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: corFundo,
        body: this._slide(),
      );
    }
  }