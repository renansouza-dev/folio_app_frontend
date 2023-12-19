import 'package:equatable/equatable.dart';

final class CompaniesEntity extends Equatable {
  final String id;
  final String name;
  final String cnpj;
  final bool broker;
  final bool listed;

  const CompaniesEntity({
    required this.id,
    required this.name,
    required this.cnpj,
    required this.broker,
    required this.listed,
  });

  @override
  List<Object?> get props => [id, name, cnpj, broker, listed];
}
