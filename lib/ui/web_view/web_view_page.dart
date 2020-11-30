import 'package:MilletFlutterApp/widget/head_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

  String url;

  String title;

  WebViewPage({this.title, this.url, Key key}): super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headView(context, "${widget.title.substring(0, 4)}"),
      body: Container(
        child: WebView(
          initialUrl: '${widget.url}',
        ),
      ),
    );
  }
}
