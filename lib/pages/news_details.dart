import 'package:flutter/material.dart';
import 'package:news_app/models/NewsModel.dart';

class NewsDetails extends StatefulWidget {
  final Image _articleImage;
  final Article _article;

  NewsDetails(this._articleImage, this._article);

  @override
  _NewsDetailsState createState() => _NewsDetailsState(_articleImage, _article);
}

class _NewsDetailsState extends State<NewsDetails> {
  Image articleImage;
  Article article;

  _NewsDetailsState(this.articleImage, this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News Details',
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: articleImage == null
                  ? SizedBox()
                  : Hero(
                      tag: article,
                      child: articleImage,
                    ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: article.description != null
                  ? Text(
                      article.description,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
