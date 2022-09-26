import 'package:flutter/material.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/core/services/news_service.dart';
import 'package:news_app/ui/widgets/widgets.dart';
import 'package:news_app/ui/widgets/news_articles.dart';
import 'package:news_app/ui/widgets/scaffold.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final NewsService newsService = NewsService();

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
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: newsService.getHeadlines(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Article>?> snapshot) {
                    Widget child = const LoadingIndicator();
                    if (snapshot.hasData) {
                      List<Article> articles = snapshot.data ?? [];
                      debugPrint(articles[4].urlToImage);
                      child = NewsArticles(articles: articles);
                    } else if (snapshot.hasError) {
                      // return error widget
                      child = const ErrorMessage();
                    }
                    return child;
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
