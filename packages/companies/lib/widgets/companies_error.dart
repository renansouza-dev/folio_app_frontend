import 'package:flutter/material.dart';

class CompaniesError extends StatelessWidget {
  const CompaniesError({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline_outlined, color: Colors.red, size: 100),
        Text('Something went wrong!', style: theme.textTheme.headlineSmall),
      ],
    );
  }
}
