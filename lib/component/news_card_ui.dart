import 'package:flutter/material.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/pages/news_details.dart';

class NewsCardUI extends StatefulWidget {
  final Article article;

  const NewsCardUI(this.article);

  @override
  _NewsCardUIState createState() => _NewsCardUIState();
}

class _NewsCardUIState extends State<NewsCardUI> {
  Image image2;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height - 300,
        width: MediaQuery.of(context).size.width - 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Color(0xffefefef),
                blurRadius: 4.0,
                spreadRadius: 2.0,
              ),
            ]
            //   BoxShadow(
            //     color: Colors.lightBlue[500],
            //     offset: Offset(-1.5, 1.5),
            //     blurRadius: 2.0,
            //   ),
            //   BoxShadow(
            //     color: Colors.lightBlue[500],
            //     offset: Offset(1.5, -1.5),
            //     blurRadius: 2.0,
            //   ),
            //   BoxShadow(
            //     color: Colors.lightBlue[500],
            //     offset: Offset(1.5, 1.5),
            //     blurRadius: 2.0,
            //   ),
            // ],
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
            SizedBox(
              height: 5,
            ),
            Container(
              // margin: const EdgeInsets.symmetric(vertical: 5),
              child: Flexible(
                flex: 3,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.article.title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
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
                      letterSpacing: 1.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
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
