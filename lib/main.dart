import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/home.dart';
import 'package:news_app/ui/theme.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: newsAppTheme,
      home: const HomeScreen(),
    );
  }
}
