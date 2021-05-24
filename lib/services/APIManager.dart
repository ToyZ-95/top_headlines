import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/constants/api_constants.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/models/countries.dart';

class APIManager {
  Future<NewsModel> getNews() async {
    var client = http.Client();
    NewsModel newsModel;

    try {
      var uri = Uri.https('newsapi.org', '/v2/top-headlines', {
        'country': Countries.selectedCountryCode == ''
            ? 'in'
            : Countries.selectedCountryCode,
        'apiKey': APIConstants.newsAPIKey,
      });

      print(uri.toString());

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
