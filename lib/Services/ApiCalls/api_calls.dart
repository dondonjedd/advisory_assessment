import 'package:advisory_assessment/Services/Helpers/api_call_helpers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../Helpers/enums.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

const baseUrl = "http://interview.advisoryapps.com";

const storage = FlutterSecureStorage();

Future<String> token() async {
  return await storage.read(key: SecureStorage.token.toString()) ?? '';
}

Future<String> id() async {
  return await storage.read(key: SecureStorage.id.toString()) ?? '';
}

Future<http.Response> logInApiCall(String email, String password) async {
  http.Response response = await callAPI(url: "$baseUrl/index.php/login", method: Method.post, apiName: "Login", body: {"email": email, "password": password});
  return response;
}

Future<http.Response> getListingApiCall() async {
  http.Response response = await callAPI(url: "$baseUrl/index.php/listing", method: Method.get, apiName: "GetListings", queryParams: {"token": await token(), "id": await id()});
  return response;
}

Future<LoginResult> logInFacebookApiCall() async {
  final LoginResult result = await FacebookAuth.instance.login();
  return result;
}

Future<Map<String, dynamic>> getUserDataFacebookApiCall() async {
  final Map<String, dynamic> result = await FacebookAuth.instance.getUserData();
  return result;
}
