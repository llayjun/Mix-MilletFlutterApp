import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ShopPageState();
  }
}

class ShopPageState extends State<ShopPage> {
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
