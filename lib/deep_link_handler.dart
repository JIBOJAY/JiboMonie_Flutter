import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; // To call your backend for decryption
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'dart:convert';

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

  // Decrypt data by calling the backend (recommended method)
  Future<void> _handleDeepLink(Uri uri) async {
    final encryptedData = uri
        .queryParameters['data']; // Assuming 'data' contains the encrypted info

    if (encryptedData != null) {
      // Send encrypted data to your backend (GAS) for decryption
      final response = await http.post(
        Uri.parse(
            'https://script.google.com/macros/s/AKfycbyWKNm56Y1mjQaEjxD9VxwRqHdsvieKCa9-Fs4MHEypWYTMI9Jbb2Hegg8ADQj452NJjA/exec'), // Your GAS URL
        body: {'data': encryptedData},
      );

      if (response.statusCode == 200) {
        final decryptedData =
            response.body; // Decrypted data from your backend (GAS)

        // Assuming response is in JSON format, parse it
        final decryptedJson = jsonDecode(decryptedData);
        final String email = decryptedJson['email'];
        final String name = decryptedJson['name'];

        // Save decrypted data in SharedPreferences
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
        debugPrint('Failed to decrypt data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _authToken == null
        ? const LoginScreen() // Show login if no token is found
        : const HomeScreen(); // Redirect to home if token exists
  }
}
