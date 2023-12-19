import 'package:folio_app_backend/src/shared/dtos/dto.dart';
import 'package:folio_app_backend/src/shared/exceptions/validate_exception.dart';

part 'companies_validate_mixin.dart';

class CompaniesDTO extends DTO with CompaniesValidate {
  late String id;
  final String name;
  final String cnpj;
  final bool broker;
  final bool listed;

  CompaniesDTO({
    String? id,
    this.name = '',
    this.cnpj = '',
    this.broker = false,
    this.listed = false,
  }) {
    this.id = id ?? '';
  }

  CompaniesDTO copy() {
    return CompaniesDTO(
      id: id,
      name: name,
      cnpj: cnpj,
      broker: broker,
      listed: listed,
    );
  }

  @override
  void validate() {
    nameValidate(name);
    cnpjValidate(cnpj);
  }
}
