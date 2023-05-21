import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'enums.dart';

/// API method
Future callAPI({
  required String url,
  required Method method,
  required String? apiName,
  Map<String, dynamic>? queryParams,
  Map<String, dynamic>? body,
  bool isFile = false,
}) async {
  // Declare a http response attribute
  http.Response response;

  // Transform the query params
  String queryString = convertParamsToString(queryParams ?? {});

  // Declare the API uri with queries
  Uri uri = queryString != '' ? Uri.parse('$url?$queryString') : Uri.parse(url);

  // Call API based on method
  switch (method) {
    case Method.get:
      response = await http.get(uri);
      break;
    case Method.post:
      response = await http.post(uri, body: body);
      break;
  }

  // Print response
  logAPIResponse(response, apiName: apiName, queryParams: queryParams, body: body);

  // Return the result
  return response;
}

//Log API response
void logAPIResponse(
  http.Response? response, {
  String? apiName,
  Map<String, dynamic>? queryParams,
  Map<String, dynamic>? body,
}) {
  debugPrint('\n=============== logAPIResponse: $apiName ================\n'
      '"url": ${response?.request}\n'
      '"statusCode": ${response?.statusCode}\n'
      '"responseBody": ${response?.body}\n'
      '"queryParams": ${queryParams ?? '{}'}\n'
      '"body": ${body != null ? json.encode(body) : '{}'}\n'
      '============= End logAPIResponse: $apiName ================\n');
}

//convert parameters to string
String convertParamsToString(Map<String, dynamic>? params) {
  // transform all value into String
  params?.forEach((key, value) => params[key] = toStr(value));

  /// Return Uri
  return Uri(queryParameters: params).query;
}

/// transform to string if boolean, int, double
String toStr(dynamic value) {
  if (value is String) {
    return value;
  } else if (value is int) {
    return value.toString();
  } else if (value is double) {
    return value.toString();
  } else if (value is bool) {
    return value.toString();
  } else {
    return '';
  }
}
