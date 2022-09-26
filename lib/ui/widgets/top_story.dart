import 'package:flutter/material.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/ui/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class TopStory extends StatelessWidget {
  const TopStory({super.key, required this.article});

  final Article? article;

  Future<void> _launchUrl(url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    const double radius = 20;
    Widget child = SizedBox(
      height: 350,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
              image: DecorationImage(
                image: getArticleImage(article?.urlToImage ?? ""),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.3),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.5, horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    child: Text(
                      "Top Story",
                      style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      article?.title ?? "",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headlineSmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchUrl(article?.url);
                    },
                    child: Row(
                      children: [
                        Text(
                          "Learn more",
                          style: textTheme.bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        const Icon(
                          Icons.arrow_right_alt_sharp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (article == null) child = Container();

    return child;
  }
}
