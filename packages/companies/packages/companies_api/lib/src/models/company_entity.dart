import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final String id;
  final String name;
  final String cnpj;
  final bool broker;
  final bool listed;

  const CompanyEntity({
    required this.id,
    required this.name,
    required this.cnpj,
    required this.broker,
    required this.listed,
  });

  factory CompanyEntity.fromJson(dynamic json) {
    return CompanyEntity(
      id: json['id'],
      name: json['name'],
      cnpj: json['cnpj'],
      broker: json['broker'],
      listed: json['listed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cnpj': cnpj,
      'broker': broker,
      'listed': listed,
    };
  }

  @override
  List<Object?> get props => [id, name, cnpj, broker, listed];
}
