import 'package:flutter/material.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/core/services/news_service.dart';
import 'package:news_app/ui/widgets/horizontal_articles.dart';
import 'package:news_app/ui/widgets/widgets.dart';
import 'package:news_app/ui/widgets/scaffold.dart';
import 'package:news_app/ui/widgets/top_story.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService newsService = NewsService();

  Future<List<Article>> getArticles() {
    return newsService.getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return NewsAppScaffold(
      pageIndex: 0,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TopStory(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Breaking News",
                style: textTheme.headlineSmall,
              ),
            ),
            // TODO: move future builder to TopStory widget
            SizedBox(
              height: 250,
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
                  } else if (snapshot.connectionState != ConnectionState.done ||
                      snapshot.connectionState != ConnectionState.none) {
                    child = const LoadingIndicator();
                  }
                  return child;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
