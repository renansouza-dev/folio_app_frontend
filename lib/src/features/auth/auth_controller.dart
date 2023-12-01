import 'package:flutter/material.dart';
import 'package:folio_app_backend/src/shared/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { idle, loading, success, failure }

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class AuthController extends ChangeNotifier {
  var state = AuthState.idle;

  Future<void> signInAction() async {
    state = AuthState.loading;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    try {
      final response = await _googleSignIn.signIn();
      final token = await response!.authentication;

      final globaUserModel = UserModel(
        displayName: response.displayName ?? '',
        email: response.email,
        token: token.accessToken ?? '',
        photoUrl: response.photoUrl ?? '',
      );

      debugPrint(globaUserModel.toJson());

      final shared = await SharedPreferences.getInstance();

      await shared.setString('UserModel', globaUserModel.toJson());
      state = AuthState.success;
      notifyListeners();
    } catch (e) {
      state = AuthState.failure;
      notifyListeners();
    }
  }

  Future<void> signOutAction() async {
    final shared = await SharedPreferences.getInstance();
    shared.remove('UserModel');

    state = AuthState.idle;
    notifyListeners();
  }
}
