import 'dart:io';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'APIClient.dart';
import 'ZoomImage.dart';

class UploadPaidGallery extends StatefulWidget {
  @override
  _UploadPaidGalleryState createState() => _UploadPaidGalleryState();
}

class _UploadPaidGalleryState extends State<UploadPaidGallery> {
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  String url="https://www.call2sex.com/api/WorkerApi/UploadPrimeGallery";
  File _image;
  var path;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        path=_image.path;
        upload();
      } else {
        print('No image selected.');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffolkey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container( color: Colors.pink[900],
                    height: MediaQuery.of(context).size.height*0.15,
                    width: MediaQuery.of(context).size.width*0.3,
                    child: RaisedButton(
                      color: Colors.pink[900],
                      onPressed: (){
                        getImage();
                      },
                      child: Icon(Icons.upload_rounded,color: Colors.white,size: 40,),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                  Container(width: MediaQuery.of(context).size.width*0.6,
                    child: Text("\nThis gallery will be visible for premium users. You will receive payment as per view.",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                      overflow: TextOverflow.clip,textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            ),
            fetchPrimeGallery()
          ],
        ),
      ),
    );
  }
  uploadImage(filename, url) async {
    SharedPreferences pref= await SharedPreferences.getInstance();
    String token= pref.getString("api_token");
    var request = http.MultipartRequest('POST', Uri.parse(url),);
    print("req");
    print(request);
    request.files.add(await http.MultipartFile.fromPath("", filename,),);

    final Map <String ,String> header= {

      'Accept': 'application/json',
      'authorization' : 'Bearer '+'$token',

    };
    request.headers.addAll(header);
    var res = await request.send();
    var response= await http.Response.fromStream(res);
    print('printing...');
    var img=await json.decode(response.body)["imgurl"];
    print(img);
    print(response.body);

    print(res.statusCode);
    print(res);
    return img;
  }
  upload()async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    String id=await preferences.getString("id");
    var res = await uploadImage(path, url);

    final result = await APIClient().savePrimeGallery(res);


    if(result["status"]=="success"){
      _scaffolkey.currentState.showSnackBar(APIClient.successToast(result["msg"]));
      (context as Element).reassemble();

    }
    else{
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast(result["msg"]));

    }
  }
  fetchPrimeGallery(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: getPics(),
        builder: (context,snap){
          if(check){
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              alignment: Alignment.center,
              child: Text("No photos found",style: TextStyle(color: Colors.pink,fontSize: 17),),
            );
          }
          if(snap.data==null){
            return Center(
              child: Container(
                height: 50,width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
          return GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              reverse: true,
              itemCount: snap.data.length,
              itemBuilder: (context,index){
                // print(snap.data[index]["imgurl"]);
                return GestureDetector(
                  onTap: (){
                    print("tapped");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ZoomImage(img: snap.data[index]["imgurl"],)));
                  },
                  onDoubleTap: (){

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(snap.data[index]["imgurl"]==null?"https://im.indiatimes.in/content/itimes/photo/2015/Jan/8/1420735448-indian-actress-sana-khan-navel-show-hot-photo-gallery-pics-pictures.jpg?w=875&h=1317&cc=1"
                                :"https://www.call2sex.com//${snap.data[index]["imgurl"].toString().replaceRange(0, 1, "")}"
                            ),
                            fit: BoxFit.fill
                        )
                    ),

                  ),

                );
              }
          );
        },
      ),
    );
  }
  bool check= false;
  getPics()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    final result= await APIClient().fetchPrimeGallery(id);
    print(result);
    if(result["status"]=="success"){

      return result["data"];
    }
    else{
      setState(() {
        check=true;
      });
    }
  }
}
