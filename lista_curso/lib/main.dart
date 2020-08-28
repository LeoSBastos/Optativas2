import 'package:flutter/material.dart';
import 'package:lista_curso/view/lista_curso.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.green[900],
    accentColor: Colors.blueAccent[700],
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueAccent[700],
      textTheme: ButtonTextTheme.primary
    )
  ),
      home: Home(),
    ));