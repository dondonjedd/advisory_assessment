import 'package:advisory_assessment/Model/user_auth.dart';
import 'package:advisory_assessment/Services/ApiCalls/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final loginProvider = Provider.autoDispose((ref) => LoginNotifier());

class LoginNotifier extends StateNotifier<UserAuth> {
  LoginNotifier() : super(UserAuth());

  Future<void> logIn(String username, String password) async {
    try {
      final response = await logInApiCall(username, password);

      if (response.statusCode == 200) {
        // Login successful, handle the response here
        debugPrint('Login successful!');
        state = UserAuth.fromJson(response.body);
      } else {
        // Login failed, handle the error response here
        throw 'Login failed: ${response.statusCode}';
      }
    } catch (error) {
      // Error occurred during the login request
      throw 'An error occurred: $error';
    }
  }

  void logOut() {
    state = UserAuth(id: '', password: '', token: '', username: '');
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, UserAuth>((ref) => LoginNotifier());
