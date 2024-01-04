import 'package:companies/companies.dart';
import 'package:flutter/material.dart';

class CompaniesListItem extends StatelessWidget {
  const CompaniesListItem({required this.entity, super.key});

  final CompanyEntity entity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const SizedBox(
        height: double.infinity,
        child: Icon(Icons.business),
      ),
      title: Text(entity.name),
      isThreeLine: true,
      subtitle: Text(entity.cnpj),
      dense: true,
      trailing: const Icon(Icons.arrow_right),
    );
  }
}
