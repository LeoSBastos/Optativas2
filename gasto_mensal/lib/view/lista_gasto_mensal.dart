import 'package:flutter/material.dart';
import 'package:gasto_mensal/controller/gasto_controller.dart';
import 'package:gasto_mensal/model/gasto.dart';
import 'package:gasto_mensal/view/cadastro_gasto_mensal.dart';
import 'package:gasto_mensal/view/gasto_item.dart';

class ListaGastoMensal extends StatefulWidget {
  @override
  _ListaGastoMensalState createState() => _ListaGastoMensalState();
}

class _ListaGastoMensalState extends State<ListaGastoMensal> {
  Map<String, dynamic> _ultimoRemovido;
  int _ultimoRemovidoPos;

  GastoController _gastoController = GastoController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Gasto mensal \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Cadastro.empty(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<List<GastoMensal>>(
        initialData: List(),
        future: _gastoController.findAll(),
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
              final List<GastoMensal> gastos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final GastoMensal gastoMensal = gastos[index];
                  final id = gastoMensal.id;
                  return Dismissible(
                      key: Key(id.toString()),
                      background: Container(
                          color: Colors.red,
                          child: Align(
                              alignment: Alignment(-0.9, 0.0),
                              child: Icon(Icons.delete, color: Colors.white))),
                      child: new InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Cadastro(gastoMensal)));
                          },
                          child: GastoItem(gastoMensal)),
                      onDismissed: (direction) {
                        _ultimoRemovido = gastoMensal.getGastoMensal();
                        _gastoController.excluir(id);
                        final snack = SnackBar(
                          content: Text("Gasto removido!"),
                          action: SnackBarAction(
                              label: "Desfazer",
                              onPressed: () {
                                setState(() {
                                  _gastoController.salvar(GastoMensal(
                                    null,
                                    _ultimoRemovido["ano"],
                                    _ultimoRemovido["mes"],
                                    _ultimoRemovido["finalidade"],
                                    _ultimoRemovido["valor"],
                                    _ultimoRemovido["tipo_gasto"],
                                  ));
                                });
                              }),
                          duration: Duration(seconds: 2),
                        );
                        Scaffold.of(context).removeCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(snack);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => ListaGastoMensal()),
                            (route) => false);
                      });
                },
                itemCount: gastos.length,
              );
              break;
          }
          return Text("Erro");
        },
      ),
    );
  }
}
