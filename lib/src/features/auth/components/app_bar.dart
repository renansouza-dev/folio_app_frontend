import 'package:flutter/material.dart';
import 'package:folio_app_backend/src/constants/color_constants.dart';
import 'package:folio_app_backend/src/features/auth/components/sign_out_button.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
        title: const Text(
          'Passfolio',
          style: TextStyle(
            color: scaffoldTextBackgroundColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          SignOutButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
