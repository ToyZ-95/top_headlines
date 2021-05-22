import 'package:flutter/material.dart';
import 'package:news_app/component/news_card_ui.dart';
import 'package:news_app/constants/api_constants.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/services/APIManager.dart';
import '../component/news_card_ui.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<NewsModel> newsModel;

  @override
  void initState() {
    newsModel = APIManager().getNews();
    super.initState();
  }

  Widget testNewsCardDesign() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top Headlines',
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

  final PageController pageController = PageController(initialPage: 0);
  bool horizontal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Top Headlines'),
        ),
      ),
      body: APIConstants.newsAPIKey == 'YOUR_API_KEY'
          ? Center(
              child: Text(
                'Please provide API Key',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          : Container(
              child: Center(
                child: FutureBuilder(
                  future: newsModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return PageView.builder(
                        itemCount: snapshot.data.articles.length,
                        scrollDirection:
                            !horizontal ? Axis.vertical : Axis.horizontal,
                        controller: pageController,
                        itemBuilder: (context, index) {
                          return Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: NewsCardUI(
                              snapshot.data.articles[index],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
      drawer: Drawer(
        elevation: 0.0,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: ListView(
            children: [
              Card(
                color: Colors.blue,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  title: Text(
                    'Horizontal',
                    textScaleFactor: 1.2,
                    style: TextStyle(color: Colors.white, letterSpacing: 2.0),
                  ),
                  trailing: Switch(
                    value: horizontal,
                    activeTrackColor: Colors.white,
                    onChanged: (value) {
                      setState(
                        () {
                          horizontal = value;
                        },
                      );
                    },
                  ),
                ),
              ),
              Container(
                child: Card(
                  color: Colors.blue,
                  child: ExpansionTile(
                    title: Text(
                      'Country',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.home_rounded,
                          color: Colors.white,
                        ),
                        title: Text('Home'),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Profile'),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
