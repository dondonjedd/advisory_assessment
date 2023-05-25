import 'package:advisory_assessment/Services/ApiCalls/api_calls.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FbUserDataNotifier extends StateNotifier<Map<String, dynamic>> {
  FbUserDataNotifier() : super(const {});

  Future<void> getUserData() async {
    try {
      final response = await getUserDataFacebookApiCall();

      state = response;
    } catch (error) {
      // Error occurred during the login request
      throw 'An error occurred: $error';
    }
  }

  void clearData() async {
    state = {};
  }
}

final fbUserDataProvider = StateNotifierProvider<FbUserDataNotifier, Map<String, dynamic>>((ref) => FbUserDataNotifier());
