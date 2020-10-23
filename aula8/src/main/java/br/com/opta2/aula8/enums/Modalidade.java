package br.com.opta2.aula8.enums;

public enum Modalidade {
	PRESENCIAL("Presencial"), EAD("Ensino a distância"), SEMI_PRESENCIAL("Semi presencial");

	private String descricao;

	private Modalidade(String descricao) {
		this.descricao = descricao;
	}

	public String getDescricao() {
		return descricao;
	}
}