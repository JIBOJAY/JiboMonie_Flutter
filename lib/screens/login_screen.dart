import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _redirectToWebsite,
          child: const Text('Continue with Google'),
        ),
      ),
    );
  }

  void _redirectToWebsite() {
    const url = 'https://jibo.infinityfreeapp.com/api/login';
    launchUrl(Uri.parse(url));
  }
}
