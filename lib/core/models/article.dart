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
    return Article(
        author: json["author"] ?? "",
        content: json["content"] ?? "",
        description: json["description"] ?? "",
        publishedAt: json["publishedAt"] ?? "",
        source: Source.fromJson(json["source"]),
        title: json["title"] ?? "",
        url: json["url"] ?? "",
        urlToImage: json["urlToImage"] ?? "");
  }
}

class Source {
  String id;
  String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
    );
  }
}
