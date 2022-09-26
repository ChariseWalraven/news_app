import 'package:flutter/material.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/core/services/news_service.dart';
import 'package:news_app/ui/widgets/scaffold.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final NewsService newsService = NewsService();

  String searchQuery = "";

  Future<List<Article>?> getArticles() {
    if (searchQuery != "") {
      return newsService.getArticles(searchQuery);
    }
    return newsService.getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return NewsAppScaffold(
      pageIndex: 1,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: ((value) {
                debugPrint("Submitted. Will search for $value");
                setState(() {
                  searchQuery = value;
                });
                getArticles();
              }),
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          // TODO: implement categories
        ],
      ),
    );
  }
}
