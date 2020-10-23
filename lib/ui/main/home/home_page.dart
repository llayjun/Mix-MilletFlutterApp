import 'package:MilletFlutterApp/ui/main/home/home_vm.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:MilletFlutterApp/widget/base/loading_container.dart';
import 'package:MilletFlutterApp/widget/common_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("主页"),
      ),
      body: LoadingContainer<HomeVModel>(
          refreshType: RefreshType.normal,
          successChild: (data) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${data.list[index].title}"),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizeDivider(height: Screen.h(20));
                },
                itemCount: data.list.length);
          },
          model: HomeVModel()),
    );
  }
}
