import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/string_constants.dart';
import 'package:news_app/models/NewsModel.dart';

class APIManager {
  Future<NewsModel> getNews() async {
    var client = http.Client();
    NewsModel newsModel;

    try {
      var uri = Uri.https('newsapi.org', '/v2/top-headlines', {
        'country': 'in',
        'apiKey': StringConstants.newsAPIKey,
      });

      // var uri = Uri.https('newsapi.org', '/v2/top-headlines', {
      //   'country': 'in',
      //   'apiKey': StringConstants.newsAPIKey,
      // });
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        newsModel = NewsModel.fromJson(json.decode(jsonString));
      }
    } catch (Exception) {
      print('Execution');
      return newsModel;
    }
    return newsModel;
  }
}
