// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:news_app/core/models/article.dart';

import '../secret.dart';
import 'package:http/http.dart' as http;

class NewsService {
  final String _newsApiKey = newsApiKey;
  final String _baseUrl = "https://newsapi.org/v2";

  Future<List<Article>?> getHeadlines() async {
    var url =
        Uri.parse("$_baseUrl/top-headlines?language=en&apiKey=$_newsApiKey");

    var response = await http.get(url);

    List articlesJSON = jsonDecode(response.body)["articles"];

    List<Article> articles =
        articlesJSON.map((json) => Article.fromJson(json)).toList();
    return articles;
  }
}
