import 'package:flutter/material.dart';
import 'package:folio_app_backend/src/features/auth/auth_page.dart';
import 'package:folio_app_backend/src/features/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    final shared = await SharedPreferences.getInstance();
    final user = shared.getString('UserModel');

    if (context.mounted) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AuthPage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
