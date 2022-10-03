import 'dart:convert';

import 'package:news_app/constants/api.dart';
import 'package:news_app/models/news_model.dart';
import 'package:http/http.dart' as http;


class NewsRepository {
  Future<List<News>> getNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?q=technology&lhealth=en&apiKey=3bba3a6d8ed84e3890c02f4acb9c92db';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    List<News> articleModelList = [];
    if (response.statusCode == 200) {
      for (var data in jsonData[Api.articles]) {
        if (data[Api.urlToImage] != null) {
          News articleModel = News.fromJson(data);
          articleModelList.add(articleModel);
        }
      }
      return articleModelList;
    } else {
      // returns an empty list.
      return articleModelList;
    }
  }

  Future<List<News>> getCarouselNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=ng&apiKey=${Api.api}";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    List<News> articleModelList = [];
    if (response.statusCode == 200) {
      for (var data in jsonData[Api.articles]) {
        if (data[Api.description].toString().isNotEmpty &&
            data[Api.urlToImage].toString().isNotEmpty) {
          News articleModel = News.fromJson(data);
          articleModelList.add(articleModel);
        }
      }
      return articleModelList;
    } else {
      // returns an empty list.
      return articleModelList;
    }
  }

  Future<List<News>> searchNews({required String query}) async {
    String url = '';
    if (query.isEmpty) {
      url =
      'https://newsapi.org/v2/everything?q=beyonce&from=2022-09-27&sortBy=popularity&apiKey=3bba3a6d8ed84e3890c02f4acb9c92db';
    } else {
      url =
      "https://newsapi.org/v2/everything?q=$query&from=2022-09-27&sortBy=popularity&apiKey=${Api.api}";
    }

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    List<News> articleModelList = [];
    if (response.statusCode == 200) {
      for (var data in jsonData[Api.articles]) {
        if (query.isNotEmpty && data[Api.urlToImage] != null) {
          News articleModel = News.fromJson(data);
          articleModelList.add(articleModel);
        } else if (query.isEmpty) {
          throw Exception('Query is empty');
        } else {
          throw Exception('Data was not loaded properly');
        }
      }
      return articleModelList;
    } else {
      // returns an empty list.
      return articleModelList;
    }
  }
}