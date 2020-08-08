import 'cliente.dart';

class PessoaFisica extends Cliente {
  String cpf;
  String rg;
  String sexo;
  DateTime dataDeNascimento;
  PessoaFisica(int codigo, String nome, String endereco, String uf, String cep,
      this.cpf, this.rg, this.sexo, this.dataDeNascimento)
      : super(codigo, nome, endereco, uf, cep);
  @override
  void inserir() {}
  @override
  void alterar() {}
  void validarCpf() {}
  @override
  String toString() {
    return 'Pessoa Física | Código: $codigo, Nome: $nome, Endereço: $endereco, UF: $uf, CEP: $cep, CPF: $cpf, RG: $rg, Sexo: $sexo, dataDeNascimento: $dataDeNascimento';
  }
}
