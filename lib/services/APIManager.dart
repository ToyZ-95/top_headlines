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
      //var response = await client.get(Uri(query: StringConstants.url));

      var uri = Uri.https('newsapi.org', '/v2/top-headlines', {
        'sources': 'techcrunch',
        'apiKey': '31f88efd99c94025bbd5cae58237d062'
      });

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
