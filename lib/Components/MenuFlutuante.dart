import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../Despesa.dart';
import '../Receita.dart';

class MenuFlutuante extends StatefulWidget {
  const MenuFlutuante({Key? key}) : super(key: key);

  @override
  _MenuFlutuanteState createState() => _MenuFlutuanteState();
}

class _MenuFlutuanteState extends State<MenuFlutuante> {

  Widget _menuFlutuante() {

    double opacity = 0.6;

    return SpeedDial(
      child: Icon(Icons.add),
      visible: true,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      // onClose: () => print('DIAL CLOSED'),
      tooltip: 'Adicionar',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.pink.withOpacity(opacity),
      foregroundColor: Colors.white.withOpacity(opacity),
      elevation: 0.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(Icons.arrow_downward),
          backgroundColor: Colors.red,
          label: 'Despesa',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Despesa() )),
        ),
        SpeedDialChild(
          child: Icon(Icons.arrow_upward),
          backgroundColor: Colors.green,
          label: 'Receita',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Receita() )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _menuFlutuante();
  }
}
