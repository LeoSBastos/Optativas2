import 'package:flutter/material.dart';
import 'package:projeto_final/component/cria_card.dart';
import 'package:projeto_final/component/cria_dropdown.dart';
import 'package:projeto_final/http/webclient/dados_webclient.dart';
import 'package:projeto_final/model/dados.dart';

class ListaDados extends StatefulWidget {
  @override
  _ListaDadosState createState() => _ListaDadosState();
}

class _ListaDadosState extends State<ListaDados> {
  DadosWebClient _webClient = DadosWebClient();

  var _paisSelecionado = "Global";
  _alterarPais(String novoPaisSelecionado) {
    setState(() {
      this._paisSelecionado = novoPaisSelecionado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("COVID-19"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Dados>(
            future: _webClient.findAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text("Carregando dados",
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                          textAlign: TextAlign.center));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Erro ao carregar dados",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    var dados = snapshot.data.dados;
                    List<String> _paises = List.from(dados.keys);
                    return SingleChildScrollView(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "País:",
                                          style: TextStyle(
                                              color: Colors.orange[800]),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: criaDropDownButton(_paises,
                                              _alterarPais, _paisSelecionado),
                                        )
                                      ])),
                              CardItem(
                                  _paisSelecionado, dados[_paisSelecionado]),
                            ]));
                  }
              }
            }));
  }
}
