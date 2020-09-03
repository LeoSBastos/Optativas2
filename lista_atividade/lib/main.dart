import 'package:flutter/material.dart';
import 'package:lista_atividade/view/lista_atividade.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.amber[900],
      accentColor: Colors.blueAccent[700],
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueAccent[700],
        textTheme: ButtonTextTheme.primary
      )
    ),
    home: Home(),
  ));
}