class GastoMensal {
  int _id;
  int _ano;
  String _mes;
  String _finalidade;
  double _valor;
  String _tipoGasto;

  GastoMensal(this._id, this._ano, this._mes, this._finalidade, this._valor,
      this._tipoGasto);

  String get tipoGasto => _tipoGasto;

  double get valor => _valor;

  String get finalidade => _finalidade;

  String get mes => _mes;

  int get ano => _ano;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map getGastoMensal() {
    Map<String, dynamic> gasto_mensal = Map();
    gasto_mensal["_id"] = _id;
    gasto_mensal["ano"] = _ano;
    gasto_mensal["mes"] = _mes;
    gasto_mensal["finalidade"] = _finalidade;
    gasto_mensal["valor"] = _valor;
    gasto_mensal["tipo_gasto"] = _tipoGasto;
    return gasto_mensal;
  }

  @override
  String toString() {
    return "Id: $_id\n Ano: $_ano\n Mês: $_mes\n Finalidade: $_finalidade\n" +
        " Valor: $_valor\n Tipo de Gasto: $_tipoGasto";
  }
}
