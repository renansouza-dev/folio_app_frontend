import 'package:flutter/material.dart';

class CompaniesEmpty extends StatelessWidget {
  const CompaniesEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.warning_outlined, color: Colors.amber, size: 100),
          Text('No records found!', style: theme.textTheme.headlineSmall),
        ],
      ),
    );
  }
}
