import 'package:news_app/core/models/source.dart';

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    String getAuthorFromTitle(String title) {
      List<String> results = title.split('- ');
      return results[results.length - 1];
    }

    String formatTitle(String? title) {
      String result = title ?? "";
      RegExp regExp = RegExp(
          r"(-\s[a-zA-Z0-9\s])|(\|\s[a-zA-Z]*\s\|)|([Tt]op [Ss]tories:)");

      return result.replaceAll(regExp, "");
    }

    String formatAuthor(String? author, String? title) {
      String result = author ?? "";
      if (result == "" && title != null) {
        return getAuthorFromTitle(title);
      }

      RegExp regExp = RegExp(r"https?:\/\/[a-zA-Z.a-zA-Z]*\/");

      if (result.startsWith("http") && title != null) {
        return getAuthorFromTitle(title);
      }

      return result.replaceAll(regExp, "");
    }

    // print(formatAuthor(json['author']));

    return Article(
        author: formatAuthor(json['author'], json['title']),
        content: json["content"] ?? "",
        description: json["description"] ?? "",
        publishedAt: json["publishedAt"] ?? "",
        source: Source.fromJson(json["source"]),
        title: formatTitle(json["title"]),
        url: json["url"] ?? "",
        urlToImage: json["urlToImage"] ?? "");
  }
}
