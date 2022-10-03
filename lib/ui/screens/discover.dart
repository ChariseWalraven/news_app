import 'package:flutter/material.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/core/services/news_service.dart';
import 'package:news_app/ui/widgets/scaffold.dart';
import 'package:news_app/ui/widgets/widgets.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with TickerProviderStateMixin {
  final NewsService newsService = NewsService();

  String searchQuery = "";
  late TabController _tabController;

  Future<List<Article>?> getArticles() {
    if (searchQuery != "") {
      return newsService.getArticles(searchQuery);
    }
    return newsService.getHeadlines();
  }

  void handleSubmit(String value) {
    debugPrint("Submitted. Will search for $value");
    setState(() {
      searchQuery = value;
    });
    getArticles();
  }

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    const tabBarTabs2 = [
      Tab(
        child: Text("Business"),
      ),
      Tab(
        child: Text("Entertainment"),
      ),
      Tab(
        child: Text("Health"),
      ),
      Tab(
        child: Text("Science"),
      ),
      Tab(
        child: Text("Sports"),
      ),
      Tab(
        child: Text("Technology"),
      ),
    ];
    const tabBarViewChildren2 = [
      Center(
        child: Text("Business"),
      ),
      Center(
        child: Text("Entertainment"),
      ),
      Center(
        child: Text("Health"),
      ),
      Center(
        child: Text("Science"),
      ),
      Center(
        child: Text("Sports"),
      ),
      Center(
        child: Text("Technology"),
      ),
    ];

    List<Widget> children = [
      Text(
        "Discover",
        style: textTheme.displaySmall,
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(
          "News from all over the world",
          style: textTheme.bodySmall,
        ),
      ),
      SearchBar(onSubmit: handleSubmit),
      TabBar(
        isScrollable: true,
        tabs: tabBarTabs2,
        controller: _tabController,
      ),
      Expanded(
        child: TabBarView(
          controller: _tabController,
          children: tabBarViewChildren2,
        ),
      ),
    ];

    if (searchQuery.isNotEmpty) {
      children = [
        Text(
          "Discover",
          style: textTheme.displaySmall,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            "News from all over the world",
            style: textTheme.bodySmall,
          ),
        ),
        SearchBar(onSubmit: handleSubmit),
        Text("You searched for $searchQuery")
      ];
    }
    return NewsAppScaffold(
      pageIndex: 1,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
