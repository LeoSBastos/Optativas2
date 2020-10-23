import 'dart:collection';

class Dados {
  Map<String, dynamic> dados = new Map<String, dynamic>();
  Dados.fromJson(Map<String, dynamic> json) {
    dados["Global"] = json["Global"];
    for (Map<String, dynamic> data in json["Countries"]) {
      String country = data["Country"];
      data.remove("Country");
      dados[country] = data;
    }
    print(dados);
  }
}
