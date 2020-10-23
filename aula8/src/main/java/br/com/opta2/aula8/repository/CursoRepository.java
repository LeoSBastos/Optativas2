package br.com.opta2.aula8.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import br.com.opta2.aula8.domain.Curso;
import br.com.opta2.aula8.enums.Modalidade;

@Repository
public interface CursoRepository extends CrudRepository<Curso, Long> {
	List<Curso> findByModalidade(Modalidade modalidade);
}
