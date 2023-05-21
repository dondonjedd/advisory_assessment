import 'package:advisory_assessment/ModelView/listing_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../ModelView/login_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _isLoading = false;
  bool _isInit = false;
  @override
  void initState() {
    super.initState();
    ref.read(listingProvider.notifier).getListing();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_isInit) {
      setState(() {
        _isLoading = true;
      });
      await ref.read(listingProvider.notifier).getListing();

      setState(() {
        _isLoading = false;
      });
      _isInit = true;
    }
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
      body: _isLoading
          ? ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      color: Colors.grey,
                      height: 80,
                      width: double.infinity,
                    )),
              ),
            )
          : ListView.builder(
              itemCount: listings.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: (index == listings.length - 1) ? 60 : 0),
                  child: ListTile(
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        content: Text(
                          textAlign: TextAlign.center,
                          "Distance to ${listings[index].listName} is\n${listings[index].distance} KM",
                          maxLines: 2,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ));
                    },
                    title: Text(listings[index].listName ?? ""),
                    subtitle: Text("${listings[index].distance ?? ""} KM"),
                  ),
                );
              },
            ),
    );
  }
}
