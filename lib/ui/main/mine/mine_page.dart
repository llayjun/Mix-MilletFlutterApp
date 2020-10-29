import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MinePageState();
  }
}

class MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true; //必须重写

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("我的"),
      ),
      body: Text('我的'),
    );
  }
}
