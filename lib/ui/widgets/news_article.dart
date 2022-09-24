import 'package:flutter/material.dart';
import 'package:news_app/core/models/article.dart';

class NewsArticle extends StatelessWidget {
  const NewsArticle({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(child: Image.network(article.urlToImage)),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Text(article.title),
                Text(article.author),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
