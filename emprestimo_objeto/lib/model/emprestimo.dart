class Emprestimo {
  String _nomePessoa;
  String _tipoObjeto;
  String _descricao;
  DateTime _data;
  bool _devolvida;

  Emprestimo(this._nomePessoa, this._tipoObjeto, this._descricao, this._data,
      this._devolvida);

  String get nomePessoa => _nomePessoa;

  String get tipoObjeto => _tipoObjeto;

  String get descricao => _descricao;

  DateTime get data => _data;

  bool get devolvida => _devolvida;

  Map getEmprestimo() {
    Map<String, dynamic> emprestimo = Map();
    emprestimo["nomePessoa"] = _nomePessoa;
    emprestimo["tipoObjeto"] = _tipoObjeto;
    emprestimo["descricao"] = _descricao;
    emprestimo["data"] = _data;
    emprestimo["devolvida"] = _devolvida;
    return emprestimo;
  }
}
