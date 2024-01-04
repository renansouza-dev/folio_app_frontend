import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:companies_api/companies_api.dart';
import 'package:http/http.dart' as http;

class CompanyRequestFailure implements Exception {}

class CompanyNotFoundFailure implements Exception {}

class CompaniesAlreadyExistsFailure implements Exception {}

class CompaniesApiClient {
  static const _basePath = '192.168.1.95:8080';
  static const _companyPath = 'v1/companies';
  final http.Client _httpClient;

  CompaniesApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<CompanyEntity>> getCompanies(String? id, String? cnpj,
      [int pageSize = 20]) async {
    final Map<String, dynamic> params = {'pageSize': pageSize.toString()};
    if (id != null) params.addAll({'id': id});
    if (cnpj != null) params.addAll({'cnpj': cnpj});

    final request = Uri.http(_basePath, _companyPath, params);
    final rawResponse = await _httpClient.get(request);
    if (rawResponse.statusCode >= 400) throw CompanyRequestFailure();
    if (rawResponse.statusCode == 204) throw CompanyNotFoundFailure();

    return PaginationResponse.fromJson(json.decode(rawResponse.body))
        .content
        .map((element) => CompanyEntity.fromJson(element))
        .toList();
  }

  Future<void> postCompanies(CompanyDto dto) async {
    final request = Uri.http(
      _basePath,
      _companyPath,
    );

    final rawResponse = await _httpClient.post(request, body: dto.toMap());
    if (rawResponse.statusCode != 201) {
      rawResponse.statusCode == 409
          ? throw CompaniesAlreadyExistsFailure()
          : throw CompanyRequestFailure();
    }
  }

  Future<void> deleteCompanies(String id) async {
    final request = Uri.http(
      _basePath,
      "$_companyPath/$id",
    );

    final rawResponse = await _httpClient.delete(request);
    if (rawResponse.statusCode != 204) {
      rawResponse.statusCode == 404
          ? throw CompanyNotFoundFailure()
          : throw CompanyRequestFailure();
    }
  }

  Future<void> updateCompanies(CompanyEntity entity) async {
    final request = Uri.http(
      _basePath,
      '$_companyPath/${entity.id}',
    );

    final dto = CompanyDto.fromJson(entity.toMap());
    final rawResponse = await _httpClient.patch(request, body: dto.toMap());
    if (rawResponse.statusCode != 204) {
      rawResponse.statusCode == 404
          ? throw CompanyNotFoundFailure()
          : throw CompanyRequestFailure();
    }
  }
}
