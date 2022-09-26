import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/ui/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsArticle extends StatelessWidget {
  const NewsArticle({
    super.key,
    required this.article,
    this.articleMargin = 10.0,
    required this.maxArticleHeight,
    required this.maxArticleWidth,
    this.scrollDirection = Axis.vertical,
  });

  final Article article;
  final double articleMargin;
  final double maxArticleHeight;
  final double maxArticleWidth;
  final Axis scrollDirection;

  Future<void> _launchUrl(url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Widget child = SizedBox(
      height: maxArticleHeight,
      width: maxArticleWidth,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(articleMargin),
                image: DecorationImage(
                  image: getArticleImage(article.urlToImage),
                  onError: (exception, stackTrace) =>
                      const AssetImage("assets/article-image-placeholder.jpg"),
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
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
    );

    if (scrollDirection == Axis.horizontal) {
      child = SizedBox(
        width: maxArticleWidth,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(articleMargin),
                  image: DecorationImage(
                    image: getArticleImage(article.urlToImage),
                    onError: (exception, stackTrace) => const AssetImage(
                        "assets/article-image-placeholder.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
      );
    }
    return GestureDetector(
      onTap: () {
        _launchUrl(article.url);
      },
      child: Padding(padding: EdgeInsets.all(articleMargin), child: child),
    );
  }
}
