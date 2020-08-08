abstract class Cliente {
  int codigo;
  String nome;
  String endereco;
  String uf;
  String cep;
  Cliente(this.codigo, this.nome, this.endereco, this.uf, this.cep);
  void inserir();
  void alterar();
}
