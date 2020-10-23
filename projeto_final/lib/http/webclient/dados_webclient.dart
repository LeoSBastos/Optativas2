import 'dart:convert';
import 'package:http/http.dart';
import 'package:projeto_final/model/dados.dart';
import '../web_client.dart';

class DadosWebClient {
  Future<Dados> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));
    return Dados.fromJson(jsonDecode(response.body));
  }
}
