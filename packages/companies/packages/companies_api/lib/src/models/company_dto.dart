import 'package:equatable/equatable.dart';

class CompanyDto extends Equatable {
  final String name;
  final String cnpj;
  final bool broker;
  final bool listed;

  const CompanyDto({
    required this.name,
    required this.cnpj,
    required this.broker,
    required this.listed,
  });

  factory CompanyDto.fromJson(dynamic json) {
    return CompanyDto(
      name: json['name'],
      cnpj: json['cnpj'],
      broker: json['broker'],
      listed: json['listed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cnpj': cnpj,
      'broker': broker,
      'listed': listed,
    };
  }

  @override
  List<Object?> get props => [name, cnpj, broker, listed];
}
