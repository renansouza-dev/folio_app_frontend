import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:folio_app_backend/src/shared/dtos/pageable.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import '../models/models.dart';

part 'companies_event.dart';
part 'companies_state.dart';

const _path = '/v1/companies';
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  CompaniesBloc({required this.httpClient}) : super(const CompaniesState()) {
    on<CompaniesFetched>(
      _onCompaniesFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onCompaniesFetched(
    CompaniesFetched event,
    Emitter<CompaniesState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CompaniesStatus.initial) {
        final companies = await _fetchCompanies();
        return emit(
          state.copyWith(
            status: CompaniesStatus.success,
            companies: companies.content
                .map((element) => CompaniesAdapter.fromMap(element))
                .toList(),
            hasReachedMax: companies.last,
          ),
        );
      }
      final companies = await _fetchCompanies(state.companies.length);
      companies.content.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: CompaniesStatus.success,
                companies: companies.content
                    .map((element) => CompaniesAdapter.fromMap(element))
                    .toList(),
                hasReachedMax: companies.last,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: CompaniesStatus.failure));
    }
  }

  Future<PaginationResponse> _fetchCompanies([int pageSize = 20]) async {
    try {
      final response = await httpClient.get(Uri.http(
        '192.168.1.95:8080',
        _path,
        {'pageSize': pageSize.toString()},
      ));
      if (response.statusCode == 200) {
        return PaginationResponse.fromJson(json.decode(response.body));
      } else {
        return PaginationResponse(
          content: [],
          totalPages: 0,
          totalElements: 0,
          last: true,
        );
      }
    } catch (e) {
      throw Exception('error fetching companies');
    }
  }
}


// docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' folio-app-backend
// docker exec -it postgres psql -U postgres
// CREATE DATABASE folio-dev WITH TEMPLATE folio;
// http://192.168.1.95:8080/v1/companies?pageSize=20
// http://192.168.1.95:8080/v1/companies%3FpageSize=20