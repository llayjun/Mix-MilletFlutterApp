import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ShopPageState();
  }
}

class ShopPageState extends State<ShopPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true; //必须重写

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("购物"),
      ),
      body: Text('购物'),
    );
  }
}
