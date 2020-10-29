import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoGalleryPage extends StatefulWidget {
  final List photoList;
  final int index;

  PhotoGalleryPage({this.photoList, this.index});

  @override
  _PhotoGalleryPageState createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends State<PhotoGalleryPage> {
  @override
  int currentIndex = 0;
  int initialIndex; //初始index
  int length;
  int title;

  @override
  void initState() {
    currentIndex = widget.index;
    initialIndex = widget.index;
    length = widget.photoList.length;
    title = initialIndex + 1;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      title = index + 1;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${title} / ${length}'),
        centerTitle: true,
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              PhotoViewGallery.builder(
                scrollDirection: Axis.horizontal,
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider:
                        NetworkImage(widget.photoList[index]),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    heroTag: widget.photoList[index],
                  );
                },
                itemCount: widget.photoList.length,
                // loadingChild: widget.loadingChild,
                backgroundDecoration: BoxDecoration(
                  color: Colors.black,
                ),
                pageController: PageController(initialPage: initialIndex),
                //点进去哪页默认就显示哪一页
                onPageChanged: onPageChanged,
              ),
            ],
          )),
    );
  }
}
