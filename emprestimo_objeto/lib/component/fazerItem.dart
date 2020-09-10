import 'package:emprestimo_objeto/persistence/manipula_arquivo.dart';
import 'package:flutter/material.dart';

class ConstruirItem {
  ManipulaArquivo manipulaArquivo = ManipulaArquivo();
  List emprestimoList = [];
  Map<String, dynamic> ultimoRemovido;
  int ultimoRemovidoPos;

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
                "${emprestimoList[index]["nomePessoa"]} (${emprestimoList[index]["tipoObjeto"]}) - ${emprestimoList[index]["data"].day}/${emprestimoList[index]["data"].month}/${emprestimoList[index]["data"].year}"),
            value: emprestimoList[index]["devolvida"],
            secondary: CircleAvatar(
              child: Icon(emprestimoList[index]["devolvida"]
                  ? Icons.check
                  : Icons.error),
            ),
            onChanged: (c) {
              emprestimoList[index]["devolvida"] = c;
              manipulaArquivo.saveEmprestimo(emprestimoList);
            }),
        onDismissed: (direction) {
          ultimoRemovido = Map.from(emprestimoList[index]);
          ultimoRemovidoPos = index;
          emprestimoList.removeAt(index);
          manipulaArquivo.saveEmprestimo(emprestimoList);
          final snack = SnackBar(
            content: Text(
                "Emprestimo de \"${ultimoRemovido["nomePessoa"]}\" removida!"),
            action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  emprestimoList.insert(ultimoRemovidoPos, ultimoRemovido);
                  manipulaArquivo.saveEmprestimo(emprestimoList);
                }),
            duration: Duration(seconds: 2),
          );
          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);
        });
  }
}
