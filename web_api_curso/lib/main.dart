import 'package:flutter/material.dart';
import 'package:web_api_curso/view/lista_curso.dart';

void main() {
  runApp(CursoApp());
}

class CursoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange[800],
        accentColor: Colors.orange[800],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange[800],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: ListaCurso(),
    );
  }
}
