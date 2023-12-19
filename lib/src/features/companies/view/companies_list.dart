import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio_app_backend/src/features/companies/bloc/companies_bloc.dart';

import '../widgets/widgets.dart';

class CompaniesList extends StatefulWidget {
  const CompaniesList({super.key});

  @override
  State<CompaniesList> createState() => _CompaniesListState();
}

class _CompaniesListState extends State<CompaniesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        switch (state.status) {
          case CompaniesStatus.failure:
            return const Center(child: Text('failed to fetch companies'));
          case CompaniesStatus.success:
            if (state.companies.isEmpty) {
              return const Center(child: Text('no companies'));
            }
            return ListTileTheme(
              contentPadding: const EdgeInsets.all(15),
              style: ListTileStyle.list,
              dense: true,
              child: ListView.builder(
                itemBuilder: (BuildContext ctx, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) {},
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      child: index >= state.companies.length
                          ? const BottomLoader()
                          : CompaniesListItem(
                              companies: state.companies[index]),
                    ),
                  );
                },
                // itemBuilder: (_, index) => widget(

                // ),
                itemCount: state.hasReachedMax
                    ? state.companies.length
                    : state.companies.length + 1,
                controller: _scrollController,
              ),
            );
          case CompaniesStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _onScroll() {
    if (_isBottom) context.read<CompaniesBloc>().add(CompaniesFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
