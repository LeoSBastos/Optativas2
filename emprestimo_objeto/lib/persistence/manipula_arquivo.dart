import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ManipulaArquivo {
  Future<File> _getArquivo() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/emprestimo.json");
  }

  Future<String> readEmprestimo() async {
    try {
      final file = await _getArquivo();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future<File> saveEmprestimo(List emprestimoList) async {
    String data = json.encode(emprestimoList, toEncodable: myEncode);
    final file = await _getArquivo();
    return file.writeAsString(data);
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }
}
