part of 'companies_cubit.dart';

enum CompaniesStatus { initial, loading, success, failure }

extension CompaniesStatusX on CompaniesStatus {
  bool get isInitial => this == CompaniesStatus.initial;
  bool get isLoading => this == CompaniesStatus.loading;
  bool get isSuccess => this == CompaniesStatus.success;
  bool get isFailure => this == CompaniesStatus.failure;
}

final class CompaniesState extends Equatable {
  final CompaniesStatus status;
  final List<CompanyEntity> companies;

  CompaniesState({
    this.status = CompaniesStatus.initial,
    List<CompanyEntity>? companies,
  }) : companies = companies ?? List.empty();

  CompaniesState copyWith({
    CompaniesStatus? status,
    List<CompanyEntity>? companies,
  }) {
    return CompaniesState(
      status: status ?? this.status,
      companies: companies ?? this.companies,
    );
  }

  @override
  List<Object?> get props => [status, companies];
}
