import 'package:advisory_assessment/Model/user_auth.dart';
import 'package:advisory_assessment/Services/ApiCalls/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Services/Helpers/enums.dart';

// final loginProvider = Provider.autoDispose((ref) => LoginNotifier());
const storage = FlutterSecureStorage();

class LoginNotifier extends StateNotifier<UserAuth> {
  LoginNotifier() : super(UserAuth());

  Future<void> logIn(String username, String password) async {
    try {
      final response = await logInApiCall(username, password);

      if (response.statusCode == 200) {
        // Login successful, handle the response here
        debugPrint('Login successful!');
        state = UserAuth.fromJson(response.body);
        storage.write(key: SecureStorage.token.toString(), value: state.token);
        storage.write(key: SecureStorage.id.toString(), value: state.id);
      } else {
        // Login failed, handle the error response here
        throw 'Login failed: ${response.statusCode}';
      }
    } catch (error) {
      // Error occurred during the login request
      throw 'An error occurred: $error';
    }
  }

  void logOut() async {
    storage.write(key: SecureStorage.token.toString(), value: '');
    storage.write(key: SecureStorage.id.toString(), value: '');
    state = UserAuth(id: '', password: '', token: '', username: '');
  }

  void autoLogin() async {
    const storage = FlutterSecureStorage();

    debugPrint('Login successful!');

    String? token = await storage.read(key: SecureStorage.token.toString());
    String? id = await storage.read(key: SecureStorage.id.toString());

    if (token?.isNotEmpty ?? false) {
      state = state.copyWith(token: token, id: id);
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, UserAuth>((ref) => LoginNotifier());
