import 'pessoa_fisica.dart';
import 'pessoa_juridica.dart';

void main() {
  // ignore: omit_local_variable_types
  PessoaFisica pf = PessoaFisica(1, 'Leo', 'Rua da Pindaiba', 'DF', '70000-000',
      '000.000.000-00', '0000000 SSP-DF', 'Masculino', DateTime(1999, 10, 7));
  // ignore: omit_local_variable_types
  PessoaJuridica pj = PessoaJuridica(
      2,
      'Velho da Havan',
      'Av. da FEB, 2000 - Pte. Nova, Várzea Grande - MT',
      'MT',
      '78115-000',
      '79.379.491/0050-61',
      '13.458.459-7',
      'Havan');
  print(pf);
  print(pj);
}
