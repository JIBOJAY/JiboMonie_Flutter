import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

class DeepLinkHandler extends StatefulWidget {
  const DeepLinkHandler({Key? key}) : super(key: key);

  @override
  State<DeepLinkHandler> createState() => _DeepLinkHandlerState();
}

class _DeepLinkHandlerState extends State<DeepLinkHandler> {
  String? _authToken;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _checkSavedAuthToken();
    _initDeepLinkListener();
  }

  Future<void> _checkSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _authToken = prefs.getString('authToken');
    });
  }

  void _initDeepLinkListener() {
    uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    }, onError: (error) {
      debugPrint('Error listening to deep links: $error');
    });
  }

  Future<void> _handleDeepLink(Uri uri) async {
    final email = uri.queryParameters['email'];
    final name = uri.queryParameters['name'];

    if (email != null && name != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('name', name);

      if (mounted) {
        setState(() {
          _authToken = email; // Use email as a logged-in identifier
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } else {
      debugPrint('Invalid deep link data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _authToken == null
        ? const LoginScreen() // Show login if no token is found
        : const HomeScreen(); // Redirect to home if token exists
  }
}
