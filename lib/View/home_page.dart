import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ModelView/login_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void logout() {
      ref.read(loginProvider.notifier).logOut();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [IconButton(onPressed: logout, icon: const Icon(Icons.logout))],
      ),
      body: const Center(
        child: Text('Welcome!'),
      ),
    );
  }
}
