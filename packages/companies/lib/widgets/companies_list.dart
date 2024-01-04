import 'package:companies/companies.dart';
import 'package:flutter/material.dart';

class CompaniesList extends StatelessWidget {
  const CompaniesList({
    required this.companies,
    required this.onRefresh,
    super.key,
  });

  final List<CompanyEntity> companies;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: const EdgeInsets.all(15),
      style: ListTileStyle.list,
      dense: true,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.builder(
          itemCount: companies.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (_) {},
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                margin: const EdgeInsets.all(10),
                child: CompaniesListItem(entity: companies[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
