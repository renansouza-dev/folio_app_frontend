part of 'companies_bloc.dart';

enum CompaniesStatus { initial, success, failure }

final class CompaniesState extends Equatable {
  const CompaniesState({
    this.status = CompaniesStatus.initial,
    this.companies = const <CompaniesEntity>[],
    this.hasReachedMax = false,
  });

  final CompaniesStatus status;
  final List<CompaniesEntity> companies;
  final bool hasReachedMax;

  CompaniesState copyWith({
    CompaniesStatus? status,
    List<CompaniesEntity>? companies,
    bool? hasReachedMax,
  }) {
    return CompaniesState(
      status: status ?? this.status,
      companies: companies ?? this.companies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''CompaniesState { status: $status, hasReachedMax: $hasReachedMax, companies: ${companies.length} }''';
  }

  @override
  List<Object> get props => [status, companies, hasReachedMax];
}
