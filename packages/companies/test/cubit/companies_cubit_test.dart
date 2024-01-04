import 'package:bloc_test/bloc_test.dart';
import 'package:companies/companies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCompaniesApiClient extends Mock implements CompaniesApiClient {}

const entity = CompanyEntity(
  id: "91b03daa-cbe2-4d55-8808-341e87ab4d37",
  name: "BANCO XPTO S.A.",
  cnpj: "00000000000000",
  broker: true,
  listed: false,
);

void main() {
  late CompaniesApiClient apiClient;
  late CompaniesCubit companiesCubit;

  setUp(() async {
    apiClient = MockCompaniesApiClient();

    when(() => apiClient.getCompanies(any(), any()))
        .thenAnswer((_) async => [entity]);

    companiesCubit = CompaniesCubit(apiClient);
  });

  group('CompaniesCubit', () {
    test('initial state is correct', () {
      expect(companiesCubit.state, CompaniesState());
    });

    group('getCompanies', () {
      blocTest<CompaniesCubit, CompaniesState>(
        'calls getCompanies',
        build: () => companiesCubit,
        act: (cubit) => cubit.getCompanies(null, null),
        verify: (_) {
          verify(() => apiClient.getCompanies(any(), any())).called(1);
        },
      );

      blocTest<CompaniesCubit, CompaniesState>(
        'emits [loading, failure] when getCompanies throws',
        setUp: () {
          when(() => apiClient.getCompanies(any(), any()))
              .thenThrow(Exception('oops'));
        },
        build: () => companiesCubit,
        act: (cubit) => cubit.getCompanies(null, null),
        expect: () => <CompaniesState>[
          CompaniesState(status: CompaniesStatus.loading),
          CompaniesState(status: CompaniesStatus.failure),
        ],
      );

      blocTest<CompaniesCubit, CompaniesState>(
        'emits [loading, success] when getCompanies returns companies',
        build: () => companiesCubit,
        act: (cubit) => cubit.getCompanies(null, null),
        expect: () => <dynamic>[
          CompaniesState(status: CompaniesStatus.loading),
          isA<CompaniesState>()
              .having((c) => c.status, 'status', CompaniesStatus.success)
              .having(
                  (w) => w.companies,
                  'companies',
                  isA<List<CompanyEntity>>()
                      .having((c) => c.first.id, 'id', isNotNull)
                      .having((c) => c.first.name, 'name', 'BANCO XPTO S.A.')
                      .having((c) => c.first.cnpj, 'cnpj', '00000000000000')
                      .having((c) => c.first.broker, 'broker', true)
                      .having((c) => c.first.listed, 'listed', false)),
        ],
      );

      blocTest<CompaniesCubit, CompaniesState>(
        'emits [loading, initial] when getCompanies returns empty',
        setUp: () {
          when(() => apiClient.getCompanies(any(), any()))
              .thenThrow(CompanyNotFoundFailure());
        },
        build: () => companiesCubit,
        act: (cubit) => cubit.getCompanies(null, null),
        expect: () => <CompaniesState>[
          CompaniesState(status: CompaniesStatus.loading),
          CompaniesState(status: CompaniesStatus.initial),
        ],
      );
    });
  });
}
