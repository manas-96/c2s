import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class UploadVoter extends StatefulWidget {
  @override
  _UploadVoterState createState() => _UploadVoterState();
}

class _UploadVoterState extends State<UploadVoter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload KYC"),
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing:15,childAspectRatio: 8/6),
                children: [

                  InkWell(
                    child: box(800, "Upload Voter(front)",),
                    onTap: (){
                     getImage();
                      getImage();
                      setState(() {
                        vf=_image.path;
                        print("vf");
                        print(vf);
                      });

                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                    },
                  ),
                  InkWell(
                    child: box(700, "Upload Voter(back)",),
                    onTap: (){
                      getImage();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                    },
                  ),
                  InkWell(
                    child: box(600, "Upload Adhaar(front)",),
                    onTap: (){
                      getImage();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                    },
                  ),
                  InkWell(
                    child: box(500, "Upload Adhaar(back)",),
                    onTap: (){
                      getImage();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                    },
                  ),
                  InkWell(
                    child: box(400, "Upload Pan(front)",),
                    onTap: (){
                      getImage();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                    },
                  ),

                  InkWell(
                    child: box(300, "Upload Selfie",),
                    onTap: (){
                      getImage();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                    },
                  ),
                ],
              ),
            ),

          ],
        )
      ),
    );
  }
  String vf="";
  String vb="";
  String af="";
  String ab="";
  String selfie="";
  String pan="";
  File _image;
  var path;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        path=_image.path;
        // if(path!=null) {
        //   imgList.add(path);
        //   print("imgList");
        //   print(imgList.length == 0 ? "no image" : imgList[0]);
        // }
        //upload();
      } else {
        print('No image selected.');
      }
    });

  }
  box(int num, String name,){
    //print(image==null?"no image":image.path);
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.pink[num].withOpacity(0.9),

        ),
        //alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 1,),
              Text(name,
                style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
            ],
          ),
        )
    );
  }
}
