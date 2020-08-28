class Curso {
  final String _nome;
  final int _cargaHoraria;
  Curso(this._nome, this._cargaHoraria);
  String get nome => _nome;
  int get cargaHoraria => _cargaHoraria;
  @override
  String toString() {
    return "$_nome ($_cargaHoraria)";
  }
}
