import 'package:advisory_assessment/View/facebook_home_page.dart';
import 'package:advisory_assessment/View/facebook_login_page.dart';
import 'package:advisory_assessment/View/home_page.dart';
import 'package:advisory_assessment/View/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ModelView/facebook_login_notifier.dart';
import '../ModelView/login_notifier.dart';

class MainNavigationPage extends ConsumerStatefulWidget {
  const MainNavigationPage({super.key});

  @override
  MainNavigationPageState createState() => MainNavigationPageState();
}

class MainNavigationPageState extends ConsumerState<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const LoginPage(), const FacebookLoginPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      loginProvider,
      (previous, next) {
        if (next.token?.isNotEmpty ?? false) {
          setState(() {
            _pages[0] = const HomePage();
          });
        } else {
          setState(() {
            _pages[0] = const LoginPage();
          });
        }
      },
    );
    ref.listen(
      facebookLoginProvider,
      (previous, next) {
        if (next.token?.isNotEmpty ?? false) {
          setState(() {
            _pages[1] = const FacebookHomePage();
          });
        } else {
          setState(() {
            _pages[1] = const FacebookLoginPage();
          });
        }
      },
    );

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
