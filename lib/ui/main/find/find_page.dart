import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new FindPageState();
  }
}

class FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true; //必须重写

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("发现"),
      ),
      body: Text('发现'),
    );
  }
}
