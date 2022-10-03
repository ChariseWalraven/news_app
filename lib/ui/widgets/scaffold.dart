import 'package:flutter/material.dart';
import 'package:news_app/ui/widgets/bottom_bar.dart';

// This is because of the params for the tabs. Not sure how to fix.
// ignore: must_be_immutable
class NewsAppScaffold extends StatelessWidget {
  const NewsAppScaffold({
    super.key,
    this.body,
    this.appBar,
    required this.pageIndex,
  });

  final Widget? body;
  final PreferredSizeWidget? appBar;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: body ?? Container(),
      ),
      bottomNavigationBar: NewsAppBottomBar(
        selectedIndex: pageIndex,
      ),
    );
  }
}
