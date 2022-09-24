import 'package:flutter/material.dart';
import 'package:news_app/ui/widgets/scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NewsAppScaffold(
      body: Text("News App Home Screen"),
    );
  }
}
