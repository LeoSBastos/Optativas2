import 'cliente.dart';

class PessoaJuridica extends Cliente {
  String cnpj;
  String inscricaoEstadual;
  String razaoSocial;
  PessoaJuridica(int codigo, String nome, String endereco, String uf,
      String cep, this.cnpj, this.inscricaoEstadual, this.razaoSocial)
      : super(codigo, nome, endereco, uf, cep);
  @override
  void inserir() {}
  @override
  void alterar() {}
  void validarCpf() {}
  @override
  String toString() {
    return 'Pessoa Jurídica | Código: $codigo, Nome: $nome, Endereço: $endereco, UF: $uf, CEP: $cep, CNPJ: $cnpj, Inscrição Estadual: $inscricaoEstadual, Razão Social: $razaoSocial';
  }
}
