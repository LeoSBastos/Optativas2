import 'package:flutter/material.dart';
import 'package:lista_curso/model/curso.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Curso> cursos = <Curso>[
    new Curso("Java Basico", 40),
    new Curso("Python avançado", 30),
    new Curso("Angular Basico", 20)
  ];

  TextEditingController _cursoController = TextEditingController();
  TextEditingController _cargaHoraria = TextEditingController();

  void _inserir() {
    setState(() {
      cursos.insert(0,
          new Curso(_cursoController.text, int.tryParse(_cargaHoraria.text)));
    });
  }

  _limparFormulario() {
    _cursoController.text = "";
    _cargaHoraria.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Lista de cursos"),
              centerTitle: true,
              //backgroundColor: Colors.brown,
            ),
            body: Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                      controller: _cursoController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Curso'))),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                      controller: _cargaHoraria,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Carga Horária'))),
              RaisedButton(
                  child: Text('Inserir'),
                  onPressed: () {
                    _inserir();
                    _limparFormulario();
                  }),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    itemCount: cursos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 50,
                          margin: EdgeInsets.all(2.0),
                          color: cursos[index].cargaHoraria >= 40
                              ? Colors.blue[400]
                              : cursos[index].cargaHoraria >= 30
                                  ? Colors.blue[100]
                                  : Colors.grey,
                          child: Center(
                              child: Text("${cursos[index]}",
                                  style: TextStyle(fontSize: 18))));
                    }),
              )
            ])));
  }
}
