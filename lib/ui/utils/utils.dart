import 'package:flutter/material.dart';

ImageProvider getArticleImage(String urlToImage) {
  if (urlToImage == "") {
    return const AssetImage("assets/article-image-placeholder.jpg");
  } else {
    return NetworkImage(urlToImage);
  }
}
