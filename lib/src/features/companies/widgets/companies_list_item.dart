import 'package:flutter/material.dart';

import '../models/models.dart';

class CompaniesListItem extends StatelessWidget {
  const CompaniesListItem({required this.companies, super.key});

  final CompaniesEntity companies;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const SizedBox(
        height: double.infinity,
        child: Icon(Icons.business),
      ),
      title: Text(companies.name),
      isThreeLine: true,
      subtitle: Text(companies.cnpj),
      dense: true,
      trailing: const Icon(
        Icons.arrow_right,
      ),
    );
  }
}
