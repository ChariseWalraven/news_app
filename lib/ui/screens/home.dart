import 'package:flutter/material.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/core/services/news_service.dart';
import 'package:news_app/ui/widgets/horizontal_articles.dart';
import 'package:news_app/ui/widgets/widgets.dart';
import 'package:news_app/ui/widgets/vertical_articles.dart';
import 'package:news_app/ui/widgets/scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService newsService = NewsService();
  String searchQuery = "";

  late TextEditingController _controller;

  Future<List<Article>?> getArticles() {
    if (searchQuery != "") {
      return newsService.getArticles(searchQuery);
    }
    return newsService.getHeadlines();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return NewsAppScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                controller: _controller,
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
            Text(
              "Breaking News",
              style: textTheme.headlineSmall,
            ),
            Expanded(
              child: FutureBuilder(
                  future: getArticles(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Article>?> snapshot) {
                    Widget child = const LoadingIndicator();
                    if (snapshot.hasData) {
                      List<Article> articles = snapshot.data ?? [];
                      debugPrint(articles[4].urlToImage);
                      child = HorizontalArticles(articles: articles);
                      // child = NewsArticles(articles: articles);
                    } else if (snapshot.hasError) {
                      // return error widget
                      child = const ErrorMessage();
                    } else if (snapshot.connectionState !=
                            ConnectionState.done ||
                        snapshot.connectionState != ConnectionState.none) {
                      child = const LoadingIndicator();
                    }
                    return child;
                  }),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
