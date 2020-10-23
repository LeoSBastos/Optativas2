import 'package:flutter/material.dart';
import 'package:web_api_curso/component/curso_item.dart';
import 'package:web_api_curso/http/webclient/curso_webclient.dart';
import 'package:web_api_curso/model/curso.dart';
import 'package:web_api_curso/view/cadastro_curso.dart';

class ListaCurso extends StatefulWidget {
  @override
  _ListaCursoState createState() => _ListaCursoState();
}

class _ListaCursoState extends State<ListaCurso> {
  List<Curso> _listaCursos = [];
  CursoWebClient _cursoWebClient = CursoWebClient();
  @override
  void initState() {
    super.initState();
    _cursoWebClient.findAll().then((dados) {
      setState(() {
        _listaCursos = dados;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lista de cursos"),
      ),
      body: FutureBuilder<List<Curso>>(
        initialData: _listaCursos,
        future: _cursoWebClient.findAll(),
// ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Carregando..."),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Curso> cursos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Curso curso = cursos[index];
                  return CursoItem(curso, _listaCursos, index);
                },
                itemCount: cursos.length,
              );
              break;
          }
          return Text("Erro");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CadastroCurso(),
              ),
            );
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange[800],
      ),
    );
  }
}
