import 'package:flutter/material.dart';

class ZoomImage extends StatefulWidget {
  final img;

  const ZoomImage({Key key, this.img}) : super(key: key);
  @override
  _ZoomImageState createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[900],
          actions: [
            // Padding(
            //   padding: const EdgeInsets.only(right:15.0),
            //   child: Icon(Icons.delete,
            //     color: Colors.white,),
            // )
          ],
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://www.call2sex.com//${widget.img.toString().replaceRange(0, 1, "")}"),fit: BoxFit.contain
              )
            ),
          ),
        ),

      ),
    );
  }
}
