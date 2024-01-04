import 'package:companies/companies.dart';
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
        extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.add_business),
        //       onPressed: () {
        //         // Navigator.of(context).push<void>(
        //         //   SettingsPage.route(context.read<WeatherCubit>()),
        //         // );
        //       },
        //     ),
        //   ],
        // ),
        body: Center(
          child: BlocConsumer<CompaniesCubit, CompaniesState>(
            builder: (context, state) {
              switch (state.status) {
                case CompaniesStatus.initial:
                  return const CompaniesEmpty();
                case CompaniesStatus.loading:
                  return const CompaniesLoading();
                case CompaniesStatus.success:
                  if (state.companies.isEmpty) {
                    return const CompaniesEmpty();
                  } else {
                    return CompaniesList(
                      companies: state.companies,
                      onRefresh: () {
                        return context
                            .read<CompaniesCubit>()
                            .getCompanies(null, null);
                      },
                    );
                  }
                case CompaniesStatus.failure:
                  return const CompaniesError();
              }
            },
            listener: (context, state) {},
          ),
        ));
  }
}
