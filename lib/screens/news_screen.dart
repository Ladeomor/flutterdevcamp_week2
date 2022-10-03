import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
class NewsDetails extends StatefulWidget {
  String? newsUrl;
   NewsDetails({Key? key,  this.newsUrl}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  NewsController newsController = NewsController();

  final Completer<WebViewController> controller =
  Completer<WebViewController>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
          initialUrl: widget.newsUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            setState(() {
              controller.complete(webViewController);
            });
          },
        )
    );
  }
}
