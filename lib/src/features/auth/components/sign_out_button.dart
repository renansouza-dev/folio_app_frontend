import 'package:flutter/material.dart';
import 'package:folio_app_backend/src/features/splash/splash_page.dart';
import 'package:provider/provider.dart';

import '../auth_controller.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();

    return IconButton(
      icon: const Icon(
        Icons.logout,
      ),
      onPressed: () {
        controller.signOutAction();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SplashPage(),
          ),
        );
      },
    );
  }
}
