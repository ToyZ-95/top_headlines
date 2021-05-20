import 'package:flutter/material.dart';
import 'package:news_app/component/news_card.dart';
import 'package:news_app/component/news_card_ui.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/services/APIManager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool firstCall = true;

  Future<NewsModel> newsModel = null;

  @override
  void initState() {
    // TODO: implement initState
    //newsModel = APIManager().getNews();
    super.initState();
  }

  void refreshPage() {
    newsModel = null;
    newsModel = APIManager().getNews();
    firstCall = false;
    setState(() {});
  }

  List<Widget> getNewsWidgets(AsyncSnapshot<NewsModel> snapshot) {
    int length = snapshot.data.articles.length;
    List<Widget> newsWidgets = [];

    for (int i = 0; i < length; i++) {
      var article = snapshot.data.articles[i];

      newsWidgets.add(
        NewsCardUI(article),
      );
    }

    return newsWidgets;
  }

  Widget testNewsCardDesign() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News App',
        ),
      ),
      body: Container(
        color: Colors.white,
        child: NewsCardUI(
          Article(
            title:
                'Chhattisgarh CGBSE 10th Result 2021 LIVE Updates: Website down, call on these numbers',
            urlToImage:
                'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1189&q=80',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //return testNewsCardDesign();
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
                actions: [
                  IconButton(
                    icon: Icon(Icons.refresh_rounded),
                    onPressed: refreshPage,
                  ),
                ],
              ),
              body: Container(
                color: Colors.white,
                child: TabBarView(
                  children: getNewsWidgets(snapshot),
                ),
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
                actions: [
                  IconButton(
                    icon: Icon(Icons.refresh_rounded),
                    onPressed: refreshPage,
                  ),
                ],
              ),
              body: Container(
                color: Colors.white,
                child: Center(
                  child: firstCall
                      ? SizedBox(
                          child: Text(
                            'Welcome to News App',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                            ),
                          ),
                        )
                      : CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
