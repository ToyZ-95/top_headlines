import 'package:flutter/material.dart';
import 'package:news_app/component/custom_dropdown.dart';
import 'package:news_app/component/news_card_ui.dart';
import 'package:news_app/constants/api_constants.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/models/countries.dart';
import 'package:news_app/services/APIManager.dart';
import '../component/news_card_ui.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<NewsModel> newsModel;
  Map<String, String> countriesAndCode;

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
    newsModel = APIManager().getNews();
    countriesAndCode = Countries.getCountriesAndCode();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder:
                    (BuildContext context, StateSetter setBottomSheetState) {
                  return Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Switch(
                                value: horizontal,
                                onChanged: (value) {
                                  setBottomSheetState(() {
                                    setState(() {
                                      horizontal = value;
                                    });
                                  });
                                },
                                activeTrackColor: Colors.white,
                                activeColor: Colors.white,
                              ),
                              Text(
                                'Horizontal Scroll',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(width: 16.0),
                          Column(
                            children: [
                              Text(
                                'Country',
                                textScaleFactor: 1.3,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 9.0,
                              ),
                              CustomDropDown(
                                countriesAndCode.keys.toList(),
                              ),
                            ],
                          ),
                          SizedBox(width: 16.0),
                          Column(
                            children: [
                              SizedBox(
                                height: 8.0,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (Countries.selectedCountry == '') {
                                    Countries.selectedCountryCode = 'in';
                                  } else {
                                    Countries.selectedCountryCode =
                                        countriesAndCode[
                                            Countries.selectedCountry];
                                  }
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Text('Save'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
