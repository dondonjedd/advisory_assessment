import 'package:advisory_assessment/Model/list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListingNotifier extends StateNotifier<List<ListItem>> {
  ListingNotifier() : super(const []);
}

final listingProvider = StateNotifierProvider<ListingNotifier, List<ListItem>>((ref) => ListingNotifier());
