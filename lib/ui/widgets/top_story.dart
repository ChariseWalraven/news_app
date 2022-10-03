import 'package:flutter/material.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/core/services/news_service.dart';
import 'package:news_app/ui/utils/utils.dart';
import 'package:news_app/ui/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class TopStory extends StatelessWidget {
  TopStory({super.key});

  final NewsService newsService = NewsService();

  Future<Article> getTopStory() {
    return newsService.getTopStory();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Widget child = FutureBuilder(
        future: getTopStory(),
        builder: (context, AsyncSnapshot<Article> snapshot) {
          Widget child = const LoadingIndicator();
          if (snapshot.hasData && snapshot.data != null) {
            child = _content(snapshot.data, textTheme);
          } else if (snapshot.hasError) {
            // return error widget
            child = const ErrorMessage();
          } else if (snapshot.connectionState != ConnectionState.done ||
              snapshot.connectionState != ConnectionState.none) {
            child = const LoadingIndicator();
          } else {
            child = Container();
          }
          return child;
        });

    return child;
  }

  Widget _content(Article? article, TextTheme textTheme) {
    const double radius = 20;

    return SizedBox(
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
                      color: Colors.black.withOpacity(0.8),
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
  }

  Future<void> _launchUrl(url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }
}
