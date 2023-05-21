import 'dart:convert';

import 'package:advisory_assessment/Model/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Services/ApiCalls/api_calls.dart';

class ListingNotifier extends StateNotifier<List<ListItem>> {
  ListingNotifier() : super(const []);

  Future<void> getListing() async {
    try {
      final response = await getListingApiCall();

      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
        List<ListItem> tempList = [];
        tempList = (json.decode(response.body)['listing'] as List).map((e) => ListItem.fromMap(e)).toList();
        state = tempList;
      } else {
        // Login failed, handle the error response here
        throw 'Login failed: ${response.statusCode}';
      }
    } catch (error) {
      // Error occurred during the login request
      throw 'An error occurred: $error';
    }
  }

  void clearListing() async {
    state = [];
  }
}

final listingProvider = StateNotifierProvider<ListingNotifier, List<ListItem>>((ref) => ListingNotifier());
