import 'package:news/models/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsApi {
  List<Article> news = [];

  Future<void> getNews() async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=eg&sortBy=publishedAt&language=ar&apiKey=55d5805e7d424583a60dc67642a0c26b';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
              title: element['title'],
              author: element['author'],
              published: DateTime.parse(element['publishedAt']),
              imgUrl: element['urlToImage'],
              content: element['content'],
              articleUrl: element['url'],
              description: element['description']);
          news.add(article);
        }
      });
    }
  }
}

class CategoryNewsApi {
  List<Article> news = [];

  Future<void> getCategoryNews(String category) async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=eg&category=$category&apiKey=55d5805e7d424583a60dc67642a0c26b';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
              title: element['title'],
              author: element['author'],
              published: DateTime.parse(element['publishedAt']),
              imgUrl: element['urlToImage'],
              content: element['content'],
              articleUrl: element['url'],
              description: element['description']);
          news.add(article);
        }
      });
    }
  }
}
