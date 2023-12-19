part of 'companies_dto.dart';

mixin class CompaniesValidate {
  void nameValidate(String name) {
    if (name.isEmpty) {
      throw 'O nome não pode ser vazio'.asException();
    }
  }

  void cnpjValidate(String cnpj) {
    if (cnpj.isEmpty) {
      throw 'O CNPJ não pode ser vazio'.asException();
    }

    if (cnpj.trim().length != 14) {
      throw 'O CNPJ deve conter 14 dígitos'.asException();
    }
  }
}
