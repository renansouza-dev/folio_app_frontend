import 'package:flutter/material.dart';

class CompaniesLoading extends StatelessWidget {
  const CompaniesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('⛅', style: TextStyle(fontSize: 64)),
        Text('Loading Companies' /*, style: theme.textTheme.headlineSmall*/),
        Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())
      ],
    );
  }
}
