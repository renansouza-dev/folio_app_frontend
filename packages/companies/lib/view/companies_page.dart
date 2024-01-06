import 'package:companies/companies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompaniesPage extends StatelessWidget {
  const CompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompaniesCubit(context.read<CompaniesApiClient>())
        ..getCompanies(null, null),
      child: const CompaniesView(),
    );
  }
}

class CompaniesView extends StatefulWidget {
  const CompaniesView({super.key});

  @override
  State<CompaniesView> createState() => _CompaniesViewState();
}

class _CompaniesViewState extends State<CompaniesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Companhias'),
      ),
      body: BlocListener<CompaniesCubit, CompaniesState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == CompaniesStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Something went wrong')),
              );
          }
        },
        child: BlocBuilder<CompaniesCubit, CompaniesState>(
          builder: (context, state) {
            if (state.companies.isEmpty) {
              return state.status == CompaniesStatus.loading
                  ? const Center(child: CupertinoActivityIndicator())
                  : const CompaniesEmpty();
            }

            return RefreshIndicator(
              onRefresh: () =>
                  context.read<CompaniesCubit>().getCompanies(null, null),
              child: ListView(
                children: [
                  for (final company in state.companies)
                    CompaniesItem(
                      company: company,
                      onDismissed: (_) {
                        context
                            .read<CompaniesCubit>()
                            .deleteCompanies(company.id);
                        state.companies.remove(company);
                      },
                      onTap: () {
                        // Navigator.of(context).push(
                        //   EditTodoPage.route(initialTodo: todo),
                        // );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
