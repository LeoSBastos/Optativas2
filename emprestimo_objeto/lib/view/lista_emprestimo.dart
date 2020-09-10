import 'dart:convert';

import 'package:emprestimo_objeto/component/fazerItem.dart';
import 'package:emprestimo_objeto/model/emprestimo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _nomeController = TextEditingController();
  final _tipoController = TextEditingController();
  final _descricaoController = TextEditingController();
  DateTime _dataInfo = DateTime.now();
  ConstruirItem ci = new ConstruirItem();

  void _changeDate() async {
    final dataSelecionada = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1967),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        });
    if (dataSelecionada != null && dataSelecionada != _dataInfo) {
      setState(() {
        _dataInfo = dataSelecionada;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    ci.manipulaArquivo.readEmprestimo().then((dado) {
      setState(() {
        ci.emprestimoList = json.decode(dado);
      });
    });
  }

  void _addEmprestimo() {
    setState(() {
      Map<String, dynamic> novoEmprestimo = Map();
      Emprestimo emprestimo = Emprestimo(_nomeController.text,
          _tipoController.text, _descricaoController.text, _dataInfo, false);
      novoEmprestimo = emprestimo.getEmprestimo();
      _nomeController.text = "";
      _tipoController.text = "";
      _descricaoController.text = "";
      ci.emprestimoList.add(novoEmprestimo);
      ci.manipulaArquivo.saveEmprestimo(ci.emprestimoList);
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      ci.emprestimoList.sort((a, b) {
        if (a["devolvida"] && !b["devolvida"])
          return 1;
        else if (!a["devolvida"] && b["devolvida"])
          return -1;
        else
          return 0;
      });
      ci.manipulaArquivo.saveEmprestimo(ci.emprestimoList);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Emprestimos"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _nomeController,
                    decoration: InputDecoration(labelText: "Nome da Pessoa"),
                  ),
                ),
              ])),
          Container(
              padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _tipoController,
                    decoration: InputDecoration(labelText: "Tipo do Objeto"),
                  ),
                ),
              ])),
          Container(
              padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _descricaoController,
                    decoration: InputDecoration(labelText: "Descricao"),
                  ),
                ),
              ])),
          FlatButton(
              child: Row(
                children: <Widget>[
                  Text("${_dataInfo.day}/${_dataInfo.month}/${_dataInfo.year}"),
                  Icon(Icons.calendar_today)
                ],
              ),
              onPressed: _changeDate),
          RaisedButton(
            child: Text("Adicionar"),
            color: Colors.blueAccent[700],
            textColor: Colors.white,
            onPressed: _addEmprestimo,
          ),
          Expanded(
              child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 10.0),
                      itemCount: ci.emprestimoList.length,
                      itemBuilder: (context, index) {
                        return ci.buildItem(context, index);
                      })))
        ],
      ),
    );
  }
}
