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
              Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: NetworkImage(article.urlToImage),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  article.title,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  article.content,
                  overflow: TextOverflow.clip,
                ),
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
              child: Scaffold(
                appBar: AppBar(
                  title: Center(
                    child: Text('News App'),
                  ),
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        });
  }
}
