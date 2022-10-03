import 'dart:convert';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/core/secret.dart';

import 'package:http/http.dart' as http;

class NewsService {
  final String _newsApiKey = newsApiKey;
  final String _baseUrl = "https://newsapi.org/v2";

  Future<List<Article>> getHeadlines({bool withoutTopStory = false}) {
    var url =
        Uri.parse("$_baseUrl/top-headlines?language=en&apiKey=$_newsApiKey");

    return _getUrl(url, removeFirst: withoutTopStory);
  }

  Future<List<Article>> getArticles(String searchQuery) {
    var url = Uri.parse(
        "$_baseUrl/everything?q=$searchQuery&language=en&apiKey=$_newsApiKey");

    return _getUrl(url);
  }

  Future<Article> getTopStory() async {
    var url = Uri.parse(
        "$_baseUrl/top-headlines?language=en&apiKey=$_newsApiKey&pageSize=1");

    List<Article>? articles = await _getUrl(url);

    return articles[0];
  }

  Future<List<Article>> _getUrl(url, {bool removeFirst = false}) async {
    var response = await http.get(url);

    List articlesJSON = jsonDecode(response.body)["articles"];

    if (removeFirst) articlesJSON.removeAt(0);

    List<Article> articles =
        articlesJSON.map((json) => Article.fromJson(json)).toList();

    return articles;
  }
}
