import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const request = "https://api.hgbrasil.com/finance?format=json&key=89e63930";

class Requisicao {
  Future<Map> getDados() async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }
}
