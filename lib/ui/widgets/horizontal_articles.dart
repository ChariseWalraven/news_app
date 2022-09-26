import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/ui/widgets/news_article.dart';

class HorizontalArticles extends StatelessWidget {
  const HorizontalArticles({super.key, required this.articles});

  final List<Article> articles;
  final double articleMargin = 10.0;

  @override
  Widget build(BuildContext context) {
    double maxArticleHeight = MediaQuery.of(context).size.width / 3;
    double maxArticleWidth = MediaQuery.of(context).size.width / 2;
    return ListView.builder(
      itemCount: articles.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return NewsArticle(
          article: articles[index],
          maxArticleHeight: maxArticleHeight,
          maxArticleWidth: maxArticleWidth,
          scrollDirection: Axis.horizontal,
        );
      },
    );
  }
}
