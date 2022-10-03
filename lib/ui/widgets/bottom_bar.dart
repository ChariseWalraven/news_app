import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/discover.dart';
import 'package:news_app/ui/screens/home.dart';

class NewsAppBottomBar extends StatefulWidget {
  const NewsAppBottomBar({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  State<NewsAppBottomBar> createState() => _NewsAppBottomBarState();
}

class _NewsAppBottomBarState extends State<NewsAppBottomBar> {
  void nagivate(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: widget.selectedIndex,
      onTap: (int index) {
        // home screen
        if (index == 0) {
          nagivate(context, HomeScreen());
        } else {
          nagivate(context, const DiscoverScreen());
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "",
        ),
      ],
    );
  }
}
