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
    return NewsAppScaffold(
      body: Center(
        child: FutureBuilder(
            future: newsService.getHeadlines(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Article>?> snapshot) {
              Widget child = const LoadingIndicator();
              if (snapshot.hasData) {
                List<Article> articles = snapshot.data ?? [];
                child = NewsArticles(articles: articles);
              } else if (snapshot.hasError) {
                // return error widget
                child = const ErrorMessage();
              }
              return child;
            }),
      ),
    );
  }
}
