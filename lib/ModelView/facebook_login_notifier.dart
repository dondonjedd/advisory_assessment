import 'package:advisory_assessment/Model/user_auth.dart';
import 'package:advisory_assessment/Services/ApiCalls/api_calls.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../Services/Helpers/enums.dart';

// final loginProvider = Provider.autoDispose((ref) => LoginNotifier());
const storage = FlutterSecureStorage();

class UserAuthNotifier extends StateNotifier<UserAuth> {
  UserAuthNotifier() : super(UserAuth());

  Future<void> logIn() async {
    try {
      LoginResult response = await logInFacebookApiCall();

      if (response.status == LoginStatus.success) {
        // you are logged
        final AccessToken accessToken = response.accessToken!;
        state = UserAuth(id: accessToken.userId, token: accessToken.token, username: "");
        storage.write(key: SecureStorage.token.toString(), value: state.token);
        storage.write(key: SecureStorage.id.toString(), value: state.id);
      } else {
        throw 'Login failed: ${response.status} - ${response.message}';
      }
    } catch (error) {
      // Error occurred during the login request
      throw 'An error occurred: $error';
    }
  }

  void logOut() async {
    await FacebookAuth.instance.logOut();
    storage.write(key: SecureStorage.token.toString(), value: '');
    storage.write(key: SecureStorage.id.toString(), value: '');
  }
}

final facebookLoginProvider = StateNotifierProvider<UserAuthNotifier, UserAuth>((ref) => UserAuthNotifier());
