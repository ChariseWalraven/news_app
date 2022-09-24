import 'package:flutter/material.dart';

class NewsAppScaffold extends StatelessWidget {
  const NewsAppScaffold({
    super.key,
    this.body,
    this.appBar,
  });

  final Widget? body;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: body ?? Container(),
      ),
    );
  }
}
