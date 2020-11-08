import 'package:call2sex/UploadFreeGalllery.dart';
import 'package:call2sex/UploadPaidGallery.dart';
import 'package:flutter/material.dart';

class UploadGallery extends StatefulWidget {
  @override
  _UploadGalleryState createState() => _UploadGalleryState();
}

class _UploadGalleryState extends State<UploadGallery> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.pink[900],
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Free Gallery',),
                Tab(text: 'Paid Gallery',),
              ],
            ),
            title: Text('Upload Gallery',style: TextStyle(fontSize: 24,color: Colors.white),),

          ),
          body: TabBarView(
            children: [
              UploadFreeGallery(),
              UploadPaidGallery()

            ],
          ),
        ),
      ),
    );
  }
}
