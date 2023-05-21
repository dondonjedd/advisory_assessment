import 'package:advisory_assessment/Services/Helpers/api_call_helpers.dart';
import 'package:http/http.dart' as http;
import '../Helpers/enums.dart';

const baseUrl = "http://interview.advisoryapps.com";

Future<http.Response> logInApiCall(String email, String password) async {
  http.Response response = await callAPI(url: "$baseUrl/index.php/login", method: Method.post, apiName: "Login", body: {"email": email, "password": password});
  return response;
}
