import 'package:flutter/material.dart';
import 'package:news_app/core/models/article.dart';

class NewsArticles extends StatelessWidget {
  const NewsArticles({
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

class NewsArticle extends StatelessWidget {
  const NewsArticle({
    super.key,
    required this.article,
    this.articleMargin = 10.0,
    required this.maxArticleHeight,
    required this.maxArticleWidth,
  });

  final Article article;
  final double articleMargin;
  final double maxArticleHeight;
  final double maxArticleWidth;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ImageProvider<Object> image;
    if (article.urlToImage == "") {
      image = const AssetImage("assets/article-image-placeholder.jpg");
    } else {
      image = NetworkImage(article.urlToImage);
    }
    return Padding(
      padding: EdgeInsets.all(articleMargin),
      child: SizedBox(
        height: maxArticleHeight,
        width: maxArticleWidth,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: maxArticleHeight,
                width: maxArticleWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(articleMargin),
                  image: DecorationImage(
                    image: image,
                    onError: (exception, stackTrace) => const AssetImage(
                        "assets/article-image-placeholder.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: articleMargin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: textTheme.labelLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      article.author,
                      style: textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
