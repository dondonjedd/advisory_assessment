import 'package:advisory_assessment/Services/ApiCalls/api_calls.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                String password = _passwordController.text;
                // Perform login validation here
                logIn(username, password);
                // if (username == 'admin' && password == 'password') {
                //   // Navigate to the home page
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const HomePage(),
                //     ),
                //   );
                // } else {
                //   showDialog(
                //     context: context,
                //     builder: (context) => AlertDialog(
                //       title: const Text('Login Failed'),
                //       content: const Text('Invalid username or password'),
                //       actions: [
                //         TextButton(
                //           onPressed: () {
                //             Navigator.pop(context);
                //           },
                //           child: const Text('OK'),
                //         ),
                //       ],
                //     ),
                //   );
                // }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
