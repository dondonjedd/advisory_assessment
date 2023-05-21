import 'package:advisory_assessment/ModelView/listing_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ModelView/login_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(listingProvider.notifier).getListing();
  }

  @override
  Widget build(BuildContext context) {
    void logout() {
      ref.read(loginProvider.notifier).logOut();
      ref.read(listingProvider.notifier).clearListing();
    }

    final listings = ref.watch(listingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [IconButton(onPressed: logout, icon: const Icon(Icons.logout))],
      ),
      body: Center(
          child: ListView.builder(
        itemCount: listings.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listings[index].listName ?? ""),
            subtitle: Text(listings[index].distance ?? ""),
          );
        },
      )),
    );
  }
}
