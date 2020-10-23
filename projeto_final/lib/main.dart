import 'package:flutter/material.dart';
import 'package:projeto_final/view/lista_dados.dart';

void main() => runApp(ProjetoFinal());

class ProjetoFinal extends StatelessWidget {
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
      home: ListaDados(),
    );
  }
}
