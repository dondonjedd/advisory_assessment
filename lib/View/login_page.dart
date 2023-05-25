import 'package:advisory_assessment/ModelView/facebook_login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ModelView/login_notifier.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginLoading = false;
  bool _isFBLoginLoading = false;

  @override
  void initState() {
    super.initState();
    ref.read(loginProvider.notifier).autoLogin();
  }

  Future<void> _login() async {
    setState(() {
      _isLoginLoading = true;
    });
    await ref.read(loginProvider.notifier).logIn(_usernameController.text, _passwordController.text);
    setState(() {
      _isLoginLoading = false;
    });
  }

  Future<void> _facebookLogin() async {
    setState(() {
      _isFBLoginLoading = true;
    });
    try {
      await ref.read(facebookLoginProvider.notifier).logIn();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          error.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }

    setState(() {
      _isFBLoginLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 32.0),
            _isLoginLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
            const SizedBox(height: 32.0),
            _isFBLoginLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _facebookLogin,
                    child: const Text('Login with facebook'),
                  ),
          ],
        ),
      ),
    );
  }
}
