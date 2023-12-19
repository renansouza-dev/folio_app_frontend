part of 'companies_bloc.dart';

sealed class CompaniesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class CompaniesFetched extends CompaniesEvent {}
