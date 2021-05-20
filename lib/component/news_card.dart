import 'package:flutter/material.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/pages/news_details.dart';

class NewsCard extends StatefulWidget {
  final Article article;

  const NewsCard(this.article);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  Image image2;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height - 300,
        width: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.white12,
              offset: Offset(-1.5, -1.5),
              blurRadius: 2.0,
            ),
            BoxShadow(
              color: Colors.white12,
              offset: Offset(-1.5, 1.5),
              blurRadius: 2.0,
            ),
            BoxShadow(
              color: Colors.white12,
              offset: Offset(1.5, -1.5),
              blurRadius: 2.0,
            ),
            BoxShadow(
              color: Colors.white12,
              offset: Offset(1.5, 1.5),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width - 60,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: widget.article.urlToImage != null
                    ? Hero(
                        tag: widget.article,
                        child: image2 = Image(
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : LinearProgressIndicator();
                          },
                          image: NetworkImage(widget.article.urlToImage),
                          fit: BoxFit.fill,
                        ),
                      )
                    : SizedBox(),
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              child: Flexible(
                flex: 3,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.article.title,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: Colors.white,
                            offset: Offset(-1, -1),
                          ),
                          Shadow(
                            color: Colors.white,
                            offset: Offset(1, -1),
                          ),
                          Shadow(
                            color: Colors.white,
                            offset: Offset(-1, 1),
                          ),
                          Shadow(
                            color: Colors.white,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    width: double.infinity, height: 50.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetails(image2, widget.article),
                      ),
                    );
                  },
                  child: Text(
                    'Read More',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
