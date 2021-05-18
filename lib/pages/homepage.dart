import 'package:flutter/material.dart';
import 'package:news_app/constants/string_constants.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/services/APIManager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<NewsModel> newsModel = null;

  @override
  void initState() {
    // TODO: implement initState
    newsModel = APIManager().getNews();
    super.initState();
  }

  List<Widget> getNewsWidgets(AsyncSnapshot<NewsModel> snapshot) {
    int length = snapshot.data.articles.length;
    List<Widget> newsWidgets = [];

    for (int i = 0; i < length; i++) {
      var article = snapshot.data.articles[i];

      newsWidgets.add(
        Container(
          child: Column(
            children: [
              Image.network(article.urlToImage),
              Text(
                article.title,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                article.content,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }

    return newsWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsModel>(
        future: newsModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DefaultTabController(
              length: snapshot.data.articles.length,
              child: Scaffold(
                appBar: AppBar(
                  title: Center(
                    child: Text('News App'),
                  ),
                ),
                body: TabBarView(
                  children: getNewsWidgets(snapshot),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
