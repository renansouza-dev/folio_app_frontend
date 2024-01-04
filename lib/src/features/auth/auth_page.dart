import 'package:companies/companies.dart';
import 'package:flutter/material.dart';

import 'auth_controller.dart';

import 'components/sign_in_button.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<AuthController>();

    controller.addListener(() {
      if (controller.state == AuthState.failure) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro na autenticação')));
      } else if (controller.state == AuthState.success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CompaniesPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(),
          ],
        ),
      ),
    );
  }
}
