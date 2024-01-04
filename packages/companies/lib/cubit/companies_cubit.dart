import 'package:bloc/bloc.dart';
import 'package:companies/companies.dart';
import 'package:equatable/equatable.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit(this._companiesApi) : super(CompaniesState());

  final CompaniesApiClient _companiesApi;

  Future<void> getCompanies(String? id, String? cnpj) async {
    emit(state.copyWith(status: CompaniesStatus.loading));
    try {
      final companies = await _companiesApi.getCompanies(id, cnpj);
      emit(state.copyWith(
          status: CompaniesStatus.success, companies: companies));
    } on CompanyNotFoundFailure {
      emit(state.copyWith(status: CompaniesStatus.initial));
    } catch (e) {
      emit(state.copyWith(status: CompaniesStatus.failure));
    }
  }

  Future<void> postCompanies(CompanyDto dto) async {
    emit(state.copyWith(status: CompaniesStatus.loading));
    try {
      await _companiesApi.postCompanies(dto);
      emit(state.copyWith(status: CompaniesStatus.success));
    } on Exception {
      emit(state.copyWith(status: CompaniesStatus.failure));
    }
  }

  Future<void> patchCompanies(CompanyEntity entity) async {
    emit(state.copyWith(status: CompaniesStatus.loading));
    try {
      await _companiesApi.updateCompanies(entity);
      emit(state.copyWith(status: CompaniesStatus.success));
    } on Exception {
      emit(state.copyWith(status: CompaniesStatus.failure));
    }
  }

  Future<void> deleteCompanies(String id) async {
    emit(state.copyWith(status: CompaniesStatus.loading));
    try {
      await _companiesApi.deleteCompanies(id);
      emit(state.copyWith(status: CompaniesStatus.success));
    } on Exception {
      emit(state.copyWith(status: CompaniesStatus.failure));
    }
  }
}
