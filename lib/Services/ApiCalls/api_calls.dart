import 'package:advisory_assessment/Services/Helpers/api_call_helpers.dart';
import 'package:flutter/material.dart';

const baseUrl = "http://interview.advisoryapps.com";

void logIn(String email, String password) async {
  final response = await callAPI(url: "$baseUrl/index.php/login", method: Method.post, apiName: "Login", body: {"email": email, "password": password});
  debugPrint(response);
}
