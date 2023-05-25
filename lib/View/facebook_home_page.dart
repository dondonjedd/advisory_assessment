import 'package:advisory_assessment/ModelView/facebook_data_notifier.dart';
import 'package:advisory_assessment/ModelView/facebook_login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FacebookHomePage extends ConsumerStatefulWidget {
  const FacebookHomePage({super.key});
  @override
  ConsumerState<FacebookHomePage> createState() => FacebookHomePageState();
}

class FacebookHomePageState extends ConsumerState<FacebookHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    ref.read(fbUserDataProvider.notifier).getUserData();
    super.initState();
  }

  void logout() {
    ref.read(facebookLoginProvider.notifier).logOut();
    ref.read(fbUserDataProvider.notifier).clearData();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(fbUserDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook'),
        actions: [IconButton(onPressed: logout, icon: const Icon(Icons.logout))],
      ),
      body: Center(
        child: user['email'] == null || user['picture'] == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(user['picture']['data']['url']),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Email: ${user['email']}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
      ),
    );
  }
}
