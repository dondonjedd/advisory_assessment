import 'package:advisory_assessment/ModelView/facebook_login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FacebookLoginPage extends ConsumerStatefulWidget {
  const FacebookLoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<FacebookLoginPage> {
  bool _isFBLoginLoading = false;

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
        title: const Text('Facebook Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: _isFBLoginLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: _facebookLogin,
                  child: const Text('Login with facebook'),
                ),
        ),
      ),
    );
  }
}
