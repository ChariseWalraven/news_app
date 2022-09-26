import 'package:flutter/material.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/ui/widgets/news_article.dart';

class VerticalArticles extends StatelessWidget {
  const VerticalArticles({
    super.key,
    required this.articles,
  });

  final List<Article> articles;
  final double articleMargin = 10.0;

  @override
  Widget build(BuildContext context) {
    double maxArticleHeight =
        (MediaQuery.of(context).size.height / 10) - articleMargin;
    double maxArticleWidth =
        (MediaQuery.of(context).size.width / 1.5) - articleMargin;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return NewsArticle(
          article: articles[index],
          maxArticleHeight: maxArticleHeight,
          maxArticleWidth: maxArticleWidth,
        );
      },
    );
  }
}