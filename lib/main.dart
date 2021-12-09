import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneyapp/GettingStarted.dart';

void main() {
  // previne rotaçao
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      home: GettingStarted(),
      debugShowCheckedModeBanner: false,
    ));
  });

}