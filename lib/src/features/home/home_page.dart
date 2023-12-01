import 'package:flutter/material.dart';
import 'package:folio_app_backend/src/features/auth/components/app_bar.dart';
import 'package:folio_app_backend/src/features/auth/components/user_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: UserData(),
    );
  }
}
