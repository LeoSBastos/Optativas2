class Curso {
  String id;
  String nome;
  int cargaHoraria;
  String modalidade;
  Curso(this.nome, this.cargaHoraria, this.modalidade, {this.id});

  Curso.fromJson(Map<String, dynamic> json, String id_firebase)
      : nome = json["nome"],
        cargaHoraria = json["cargaHoraria"],
        modalidade = json["modalidade"],
        id = id_firebase;

  Map<String, dynamic> toMap() => {
        "nome": nome,
        "cargaHoraria": cargaHoraria,
        "modalidade": modalidade,
      };

  @override
  String toString() {
    return "Curso: $nome,\nCarga Horária: $cargaHoraria,\nmodalidade: $modalidade";
  }
}
