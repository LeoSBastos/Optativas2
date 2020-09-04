import 'dart:convert';

import 'package:emprestimo_objeto/model/emprestimo.dart';
import 'package:emprestimo_objeto/persistence/manipula_arquivo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ManipulaArquivo manipulaArquivo = ManipulaArquivo();
  final _nomeController = TextEditingController();
  final _tipoController = TextEditingController();
  final _descricaoController = TextEditingController();
  DateTime _dataInfo = DateTime.now();
  Map<String, dynamic> _ultimoRemovido;
  int _ultimoRemovidoPos;
  List _emprestimoList = [];

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
    manipulaArquivo.readEmprestimo().then((dado) {
      setState(() {
        _emprestimoList = json.decode(dado);
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
      _emprestimoList.add(novoEmprestimo);
      manipulaArquivo.saveEmprestimo(_emprestimoList);
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _emprestimoList.sort((a, b) {
        if (a["devolvida"] && !b["devolvida"])
          return 1;
        else if (!a["devolvida"] && b["devolvida"])
          return -1;
        else
          return 0;
      });
      manipulaArquivo.saveEmprestimo(_emprestimoList);
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
                      itemCount: _emprestimoList.length,
                      itemBuilder: buildItem)))
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return Dismissible(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        direction: DismissDirection.startToEnd,
        child: CheckboxListTile(
            title: Text(
                "${_emprestimoList[index]["nomePessoa"]} (${_emprestimoList[index]["tipoObjeto"]}) - ${_emprestimoList[index]["data"].day}/${_emprestimoList[index]["data"].month}/${_emprestimoList[index]["data"].year}"),
            value: _emprestimoList[index]["devolvida"],
            secondary: CircleAvatar(
              child: Icon(_emprestimoList[index]["devolvida"]
                  ? Icons.check
                  : Icons.error),
            ),
            onChanged: (c) {
              setState(() {
                _emprestimoList[index]["devolvida"] = c;
                manipulaArquivo.saveEmprestimo(_emprestimoList);
              });
            }),
        onDismissed: (direction) {
          _ultimoRemovido = Map.from(_emprestimoList[index]);
          _ultimoRemovidoPos = index;
          _emprestimoList.removeAt(index);
          manipulaArquivo.saveEmprestimo(_emprestimoList);
          final snack = SnackBar(
            content: Text(
                "Emprestimo de \"${_ultimoRemovido["nomePessoa"]}\" removida!"),
            action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  setState(() {
                    _emprestimoList.insert(_ultimoRemovidoPos, _ultimoRemovido);
                    manipulaArquivo.saveEmprestimo(_emprestimoList);
                  });
                }),
            duration: Duration(seconds: 2),
          );
          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);
        });
  }
}
