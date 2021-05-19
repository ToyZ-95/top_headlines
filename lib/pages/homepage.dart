import 'package:flutter/material.dart';
import 'package:news_app/component/news_card.dart';
import 'package:news_app/constants/string_constants.dart';
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

  Widget getCard(Article article) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Card(
        elevation: 8,
        shape: Border.all(
          width: 2.0,
          color: Colors.blue,
        ),
        shadowColor: Colors.blue,
        child: Stack(
          children: [
            article.urlToImage != null
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      image: NetworkImage(article.urlToImage),
                      fit: BoxFit.cover,
                    ),
                  )
                : SizedBox(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 40.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomLeft,
              child: Text(
                article.title,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    inherit: true,
                    fontSize: 38.0,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                          // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: Colors.black),
                      Shadow(
                          // bottomRight
                          offset: Offset(1.5, -1.5),
                          color: Colors.black),
                      Shadow(
                          // topRight
                          offset: Offset(1.5, 1.5),
                          color: Colors.black),
                      Shadow(
                          // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: Colors.black),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getNewsWidgets(AsyncSnapshot<NewsModel> snapshot) {
    int length = snapshot.data.articles.length;
    List<Widget> newsWidgets = [];

    for (int i = 0; i < length; i++) {
      var article = snapshot.data.articles[i];

      newsWidgets.add(
        getCard(article),
      );
    }

    return newsWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News App',
        ),
      ),
      body: Container(
        color: Colors.blue,
        child: NewsCard(
          Article(
            title:
                'Chhattisgarh CGBSE 10th Result 2021 LIVE Updates: Website down, call on these numbers',
            urlToImage:
                'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1189&q=80',
          ),
        ),
      ),
    );
    // return FutureBuilder<NewsModel>(
    //   future: newsModel,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return DefaultTabController(
    //         length: snapshot.data.articles.length,
    //         child: Scaffold(
    //           appBar: AppBar(
    //             title: Center(
    //               child: Text('News App'),
    //             ),
    //             actions: [
    //               IconButton(
    //                 icon: Icon(Icons.refresh_rounded),
    //                 onPressed: refreshPage,
    //               ),
    //             ],
    //           ),
    //           body: TabBarView(
    //             children: getNewsWidgets(snapshot),
    //           ),
    //         ),
    //       );
    //     } else {
    //       return Center(
    //         child: Scaffold(
    //           appBar: AppBar(
    //             title: Center(
    //               child: Text('News App'),
    //             ),
    //             actions: [
    //               IconButton(
    //                 icon: Icon(Icons.refresh_rounded),
    //                 onPressed: refreshPage,
    //               ),
    //             ],
    //           ),
    //           body: Center(
    //             child: firstCall ? SizedBox() : CircularProgressIndicator(),
    //           ),
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
