import 'package:flutter/material.dart';
import 'deep_link_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JiboMonie',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const DeepLinkHandler(), // Start with DeepLinkHandler
    );
  }
}
