import 'package:companies_api/companies_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Company Entity', () {
    group('fromJson', () {
      test('returns correct Company Entity object', () {
        expect(
          CompanyEntity.fromJson(
            const <String, dynamic>{
              "id": "91b03daa-cbe2-4d55-8808-341e87ab4d37",
              "name": "BANCO S.A.",
              "cnpj": "00000000000000",
              "broker": true,
              "listed": false
            },
          ),
          isA<CompanyEntity>()
              .having((company) => company.id, 'id',
                  '91b03daa-cbe2-4d55-8808-341e87ab4d37')
              .having((company) => company.name, 'name', 'BANCO S.A.')
              .having((company) => company.cnpj, 'cnpj', '00000000000000')
              .having((company) => company.broker, 'broker', true)
              .having((company) => company.listed, 'listed', false),
        );
      });
    });
  });

  group('Company Dto', () {
    group('toJson', () {
      test('returns correct Company Dto object', () {
        expect(
          const CompanyDto(
                  name: "BANCO C6 S.A.",
                  cnpj: "31872495000172",
                  broker: true,
                  listed: false)
              .toMap(),
          isA<Map<String, dynamic>>()
              .having((json) => json['name'], 'name', 'BANCO S.A.')
              .having((json) => json['cnpj'], 'cnpj', '00000000000000')
              .having((json) => json['broker'], 'broker', true)
              .having((json) => json['listed'], 'listed', false),
        );
      });
    });
  });
}
