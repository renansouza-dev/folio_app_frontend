import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio_app_backend/src/features/companies/bloc/companies_bloc.dart';
import 'package:folio_app_backend/src/features/companies/view/view.dart';
import 'package:http/http.dart' as http;

class CompaniesPage extends StatelessWidget {
  const CompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Companies'),
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.add_business_rounded,
            ),
            padding: EdgeInsets.only(right: 24.0),
            constraints: BoxConstraints(),
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) =>
            CompaniesBloc(httpClient: http.Client())..add(CompaniesFetched()),
        child: const CompaniesList(),
      ),
    );
  }
}
