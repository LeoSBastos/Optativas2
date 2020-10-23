import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart';
import 'package:web_api_curso/model/curso.dart';
import '../web_client.dart';

class CursoWebClient {
  Future<List<Curso>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Curso.fromJson(json)).toList();
  }

  Future<Curso> salvar(Curso curso) async {
    Response response;
    if (curso.id == null) {
      response = await client.post(baseUrl,
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode(curso.toJson()));
    } else {
      response = await client.put("$baseUrl/${curso.id}",
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode(curso.toJson()));
    }
    return Curso.fromJson(jsonDecode(response.body));
  }

  Future<Void> excluir(int id) async {
    Response response;
    response = await client.delete("$baseUrl/$id", headers: {
      'Content-type': 'application/json',
    });
  }
}
