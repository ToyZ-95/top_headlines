import 'package:flutter/material.dart';

class NewsDetails extends StatefulWidget {
  Image _articleImage;
  String _articleContent;

  NewsDetails(this._articleImage, this._articleContent);

  @override
  _NewsDetailsState createState() =>
      _NewsDetailsState(_articleImage, _articleContent);
}

class _NewsDetailsState extends State<NewsDetails> {
  Image articleImage;
  String articleContent;

  _NewsDetailsState(this.articleImage, this.articleContent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News Details'),
        ),
        body: Container(
          child: Column(
            children: [
              articleImage,
              SizedBox(height: 20.0),
              Text(
                articleContent,
              ),
            ],
          ),
        ));
  }
}
