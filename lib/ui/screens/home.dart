import 'package:flutter/material.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/core/services/news_service.dart';
import 'package:news_app/ui/widgets/news_article.dart';
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

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [CircularProgressIndicator(), Text("Loading News Items")],
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Oh no! Something went wrong! 😞");
  }
}

class NewsArticles extends StatelessWidget {
  const NewsArticles({super.key, required this.articles});

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return NewsArticle(article: articles[index]);
      },
    );
  }
}
