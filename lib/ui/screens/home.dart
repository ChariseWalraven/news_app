import 'package:flutter/material.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/core/services/news_service.dart';
import 'package:news_app/ui/widgets/horizontal_articles.dart';
import 'package:news_app/ui/widgets/widgets.dart';
import 'package:news_app/ui/widgets/scaffold.dart';
import 'package:news_app/ui/widgets/top_story.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final NewsService newsService = NewsService();

  Future<List<Article>> getArticles() {
    return newsService.getHeadlines(withoutTopStory: true);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return NewsAppScaffold(
      pageIndex: 0,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: TopStory(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  "Breaking News",
                  style: textTheme.headlineSmall,
                ),
              ),
              Expanded(
                flex: 2,
                child: FutureBuilder(
                  future: getArticles(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Article>?> snapshot) {
                    Widget child = const LoadingIndicator();
                    if (snapshot.hasData) {
                      List<Article> articles = snapshot.data ?? [];
                      child = HorizontalArticles(articles: articles);
                      // child = NewsArticles(articles: articles);
                    } else if (snapshot.hasError) {
                      // return error widget
                      child = const ErrorMessage();
                      debugPrint(snapshot.error.toString());
                    } else if (snapshot.connectionState !=
                            ConnectionState.done ||
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
      ),
    );
  }
}
