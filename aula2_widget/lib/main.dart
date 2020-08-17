import 'package:flutter/material.dart';

void main() => {runApp(MaterialApp(home: Tela()))};

class Tela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aula 2 - Primeiros passos"),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "Campo de texto do formulário",
              labelStyle: TextStyle(color: Colors.orangeAccent)),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.orangeAccent, fontSize: 18),
        ),
        Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text("Isto é um texto",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orangeAccent, fontSize: 18.0))),
        Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: RaisedButton(
              onPressed: () {},
              child: Text(
                "Clique aqui",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              color: Colors.orangeAccent,
            )),
      ])),
    );
  }
}
