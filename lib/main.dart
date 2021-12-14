import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneyapp/view/Home.dart';

void main() {
  // previne rotaçao
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));
  });

}