import 'package:folio_app_backend/src/features/companies/models/companies_dto.dart';
import 'package:folio_app_backend/src/features/companies/models/companies_entity.dart';

class CompaniesAdapter {
  CompaniesAdapter._();

  static CompaniesEntity fromMap(dynamic map) {
    return CompaniesEntity(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      cnpj: map['cnpj'] ?? '',
      broker: map['broker'] ?? false,
      listed: map['listed'] ?? false,
    );
  }

  static CompaniesDTO entityToDTO(CompaniesEntity model) {
    return CompaniesDTO(
      id: model.id,
      name: model.name,
      cnpj: model.cnpj,
      broker: model.broker,
      listed: model.listed,
    );
  }

  static Map<String, dynamic> entityToMap(CompaniesEntity model) {
    return {
      'id': model.id,
      'name': model.name,
      'cnpj': model.cnpj,
      'broker': model.broker,
      'listed': model.listed,
    };
  }

  static Map<String, dynamic> dtoToMap(CompaniesDTO model) {
    return {
      'id': model.id,
      'name': model.name,
      'cnpj': model.cnpj,
      'broker': model.broker,
      'listed': model.listed,
    };
  }
}
