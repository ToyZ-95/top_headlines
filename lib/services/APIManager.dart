import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/constants/api_constants.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/models/categories.dart';
import 'package:news_app/models/countries.dart';

class APIManager {
  Future<NewsModel> getNews() async {
    var client = http.Client();
    NewsModel newsModel;

    try {
      Uri uri;
      if (Categories.selectedCategory == 'General') {
        print('inside if');

        uri = Uri.https(
          'newsapi.org',
          '/v2/top-headlines',
          {
            'country': Countries.selectedCountryCode == ''
                ? 'in'
                : Countries.selectedCountryCode,
            'apiKey': APIConstants.newsAPIKey,
          },
        );
      } else {
        print('inside else');
        uri = Uri.https(
          'newsapi.org',
          '/v2/top-headlines',
          {
            'country': Countries.selectedCountryCode == ''
                ? 'in'
                : Countries.selectedCountryCode,
            'category': Categories.selectedCategory,
            'apiKey': APIConstants.newsAPIKey,
          },
        );
      }

      var response = await client.get(uri);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        newsModel = NewsModel.fromJson(json.decode(jsonString));
      }
    } catch (Exception) {
      print('Exception');
      return newsModel;
    }
    return newsModel;
  }
}
