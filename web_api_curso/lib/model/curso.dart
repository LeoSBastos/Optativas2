class Curso {
  int id;
  String nome;
  int cargaHoraria;
  String modalidade;
  Curso(this.nome, this.cargaHoraria, this.modalidade, {this.id});
  Map<String, dynamic> toJson() => {
        "nome": nome,
        "cargaHoraria": cargaHoraria,
        "modalidade": modalidade,
      };
  Curso.fromJson(Map<String, dynamic> json)
      : nome = json["nome"],
        cargaHoraria = json["cargaHoraria"],
        modalidade = json["modalidade"],
        id = json["id"];
  @override
  String toString() {
    return "Curso: $nome \n Carga Horária: $cargaHoraria \nmodalidade: $modalidade";
  }
}
