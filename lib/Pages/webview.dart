import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget {
  Map data ={};
  Web({this.data});
  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    widget.data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['name']),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: WebView(
        initialUrl: widget.data['urls'],
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          webViewController.loadUrl('url');
        },
      ),
    );
  }
}
