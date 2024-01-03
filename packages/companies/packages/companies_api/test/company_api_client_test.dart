import 'package:companies_api/company_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('CompanyApiClient', () {
    late http.Client httpClient;
    late CompanyApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = CompanyApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(CompanyApiClient(), isNotNull);
      });
    });

    group('companies', () {
      group('get requests', () {
        test('makes correct http request', () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn('''{
            "content": [
              {
                "id": "91b03daa-cbe2-4d55-8808-341e87ab4d37",
                "name": "BANCO C6 S.A.",
                "cnpj": "31872495000172",
                "broker": true,
                "listed": false
              }
            ],
            "pageable": {
              "pageNumber": 0,
              "pageSize": 20,
              "sort": {
                "unsorted": true,
                "sorted": false,
                "empty": true
              },
              "offset": 0,
              "paged": true,
              "unpaged": false
            },
            "totalPages": 1,
            "totalElements": 1,
            "last": true,
            "first": true,
            "numberOfElements": 1,
            "sort": {
              "unsorted": true,
              "sorted": false,
              "empty": true
            },
            "number": 0,
            "size": 20,
            "empty": false
          }''');
          when(() => httpClient.get(any())).thenAnswer((_) async => response);
          try {
            await apiClient.getCompanies(null, null);
          } catch (_) {}
          verify(
            () => httpClient.get(
              Uri.https(
                '192.168.1.95:8080',
                'v1/companies',
                {'pageSize': 20.toString()},
              ),
            ),
          ).called(1);
        });

        test('makes correct http request using cnpj', () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn('''{
            "content": [
              {
                "id": "91b03daa-cbe2-4d55-8808-341e87ab4d37",
                "name": "BANCO C6 S.A.",
                "cnpj": "31872495000172",
                "broker": true,
                "listed": false
              }
            ],
            "pageable": {
              "pageNumber": 0,
              "pageSize": 20,
              "sort": {
                "unsorted": true,
                "sorted": false,
                "empty": true
              },
              "offset": 0,
              "paged": true,
              "unpaged": false
            },
            "totalPages": 1,
            "totalElements": 1,
            "last": true,
            "first": true,
            "numberOfElements": 1,
            "sort": {
              "unsorted": true,
              "sorted": false,
              "empty": true
            },
            "number": 0,
            "size": 20,
            "empty": false
          }''');
          when(() => httpClient.get(any())).thenAnswer((_) async => response);
          try {
            await apiClient.getCompanies(null, '31872495000172');
          } catch (_) {}
          verify(
            () => httpClient.get(
              Uri.https(
                '192.168.1.95:8080',
                'v1/companies',
                {'pageSize': 20.toString(), 'cnpj': '31872495000172'},
              ),
            ),
          ).called(1);
        });

        test('makes correct http request using id', () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(200);
          when(() => response.body).thenReturn('''{
            "content": [
              {
                "id": "91b03daa-cbe2-4d55-8808-341e87ab4d37",
                "name": "BANCO C6 S.A.",
                "cnpj": "31872495000172",
                "broker": true,
                "listed": false
              }
            ],
            "pageable": {
              "pageNumber": 0,
              "pageSize": 20,
              "sort": {
                "unsorted": true,
                "sorted": false,
                "empty": true
              },
              "offset": 0,
              "paged": true,
              "unpaged": false
            },
            "totalPages": 1,
            "totalElements": 1,
            "last": true,
            "first": true,
            "numberOfElements": 1,
            "sort": {
              "unsorted": true,
              "sorted": false,
              "empty": true
            },
            "number": 0,
            "size": 20,
            "empty": false
          }''');
          when(() => httpClient.get(any())).thenAnswer((_) async => response);
          try {
            await apiClient.getCompanies(
                '91b03daa-cbe2-4d55-8808-341e87ab4d37', null);
          } catch (_) {}
          verify(
            () => httpClient.get(
              Uri.https(
                '192.168.1.95:8080',
                'v1/companies',
                {
                  'pageSize': 20.toString(),
                  'id': '91b03daa-cbe2-4d55-8808-341e87ab4d37',
                },
              ),
            ),
          ).called(1);
        });

        test('throws CompanyRequestFailure on non-200 response', () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(400);
          when(() => httpClient.get(any())).thenAnswer((_) async => response);
          expect(
            () async => apiClient.getCompanies(null, null),
            throwsA(isA<CompanyRequestFailure>()),
          );
        });

        test('throws CompanyNotFoundFailure on error response', () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(204);
          when(() => response.body).thenReturn('{}');
          when(() => httpClient.get(any())).thenAnswer((_) async => response);
          await expectLater(
            apiClient.getCompanies(null, null),
            throwsA(isA<CompanyNotFoundFailure>()),
          );
        });
      });

      group('post requests', () {
        const dto = CompanyDto(
          name: 'BANCO C6 S.A.',
          cnpj: '31872495000172',
          listed: false,
          broker: true,
        );
        test('makes correct http request', () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(201);
          when(() => httpClient.get(any())).thenAnswer((_) async => response);
          try {
            await apiClient.postCompanies(dto);
          } catch (_) {}
          verify(
            () => httpClient.post(
                Uri.https(
                  '192.168.1.95:8080',
                  'v1/companies',
                ),
                body: dto.toMap()),
          ).called(1);
        });
      });

      group('delete requests', () {
        test('makes correct http request', () async {
          const id = '082190eb-1ba8-40d6-9c40-9c3b8366961e';

          final response = MockResponse();
          when(() => response.statusCode).thenReturn(204);
          when(() => httpClient.delete(any()))
              .thenAnswer((_) async => response);
          try {
            await apiClient.deleteCompanies(id);
          } catch (_) {}
          verify(
            () => httpClient.delete(
              Uri.https('192.168.1.95:8080', 'v1/companies/$id'),
            ),
          ).called(1);
        });

        test('throws CompanyRequestFailure on non-204 response', () async {
          const id = '082190eb-1ba8-40d6-9c40-9c3b8366961e';

          final response = MockResponse();
          when(() => response.statusCode).thenReturn(400);
          when(() => httpClient.delete(any()))
              .thenAnswer((_) async => response);
          try {
            await apiClient.deleteCompanies(id);
          } catch (_) {}
          await expectLater(
            apiClient.deleteCompanies(id),
            throwsA(isA<CompanyRequestFailure>()),
          );
        });

        test('throws CompanyNotFoundFailure on error response', () async {
          const id = '082190eb-1ba8-40d6-9c40-9c3b8366961e';

          final response = MockResponse();
          when(() => response.statusCode).thenReturn(404);
          when(() => httpClient.delete(any()))
              .thenAnswer((_) async => response);
          try {
            await apiClient.deleteCompanies(id);
          } catch (_) {}
          await expectLater(
            apiClient.deleteCompanies(id),
            throwsA(isA<CompanyNotFoundFailure>()),
          );
        });
      });

      group('updateCompanies', () {
        const entity = CompanyEntity(
          id: '082190eb-1ba8-40d6-9c40-9c3b8366961e',
          name: 'BANCO C6 S.A.',
          cnpj: '31872495000172',
          listed: false,
          broker: true,
        );

        test('makes correct request', () async {
          final response = MockResponse();
          when(() => response.statusCode).thenReturn(204);
          when(() => httpClient.patch(any())).thenAnswer((_) async => response);
          try {
            await apiClient.updateCompanies(entity);
          } catch (_) {}
          verify(
            () => httpClient.patch(
              Uri.https('192.168.1.95:8080', 'v1/companies/${entity.id}'),
              body: CompanyDto.fromJson(entity.toMap()).toMap(),
            ),
          ).called(1);
        });
      });
    });
  });
}
