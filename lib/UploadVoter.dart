import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'APIClient.dart';


class UploadVoter extends StatefulWidget {
  final kyc_id;
  final kyc_adhar;
  final kyc_pan;
  final kyc_img;

  const UploadVoter({Key key, this.kyc_id, this.kyc_adhar, this.kyc_pan, this.kyc_img}) : super(key: key);
  @override
  _UploadVoterState createState() => _UploadVoterState();
}

class _UploadVoterState extends State<UploadVoter> {
  String uploadUrl="https://www.call2sex.com/api/KycApi/UploadDocs";
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldkey,
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
                    child: box(800, "Upload Voter(front)",_voterFront),
                    onTap: (){
                      voterFront();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                    },
                  ),
                  InkWell(
                    child: box(700, "Upload Voter(back)",_voterBack),
                    onTap: (){
                      voterBack();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                    },
                  ),
                  InkWell(
                    child: box(600, "Upload Adhaar(front)",_adhaarFront),
                    onTap: (){
                      adhaarFront();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                    },
                  ),
                  InkWell(
                    child: box(500, "Upload Adhaar(back)",_adhaarBack),
                    onTap: (){
                      adhaarBack();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                    },
                  ),
                  InkWell(
                    child: box(400, "Upload Pan(front)",_pan),
                    onTap: (){
                      panUpload();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                    },
                  ),
                  InkWell(
                    child: box(300, "Upload Selfie",_image),
                    onTap: (){
                      imageUpload();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 44.0,left: MediaQuery.of(context).size.width/3-12,right: MediaQuery.of(context).size.width/3-12),
              child: RaisedButton(
                onPressed: (){

                },
                color: Colors.pink[900],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Upload",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                ),
              ),
            )

          ],
        )
      ),
    );
  }

  File _voterFront;
  var pathvotarFront;
  final picker = ImagePicker();
  Future voterFront() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _voterFront = File(pickedFile.path);
        pathvotarFront=_voterFront.path;
       // uploadFront(pathvotarFront, "2");
      } else {
        //('No image selected.');
      }
    });

  }
  File _voterBack;
  var pathvoterBack;
  Future voterBack() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _voterBack = File(pickedFile.path);
        pathvoterBack=_voterBack.path;
        uploadFront(widget.kyc_id,"2",pathvotarFront,pathvoterBack);
      } else {
        //('No image selected.');
      }
    });

  }
  File _adhaarFront;
  var pathadhaarFront;
  Future adhaarFront() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _adhaarFront = File(pickedFile.path);
        pathadhaarFront=_adhaarFront.path;
      } else {
        //('No image selected.');
      }
    });

  }
  File _adhaarBack;
  var pathadhaarBack;
  Future adhaarBack() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _adhaarBack = File(pickedFile.path);
        pathadhaarBack=_adhaarBack.path;
        uploadFront(widget.kyc_adhar,"1",pathadhaarFront,pathadhaarBack);
      } else {
        //('No image selected.');
      }
    });

  }
  File _pan;
  var pan;
  Future panUpload() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _pan = File(pickedFile.path);
        pan=_pan.path;
        uploadSingle(widget.kyc_pan,"3", pan);
      } else {
        //('No image selected.');
      }
    });

  }
  File _image;
  var path;
  Future imageUpload() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        path=_image.path;
        uploadSelfie(widget.kyc_img,"4", path);
      } else {
        //('No image selected.');
      }
    });

  }
  box(int num, String name, File img){
    ////(image==null?"no image":image.path);
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.pink[num],

                  image: DecorationImage(
                      image:img==null?AssetImage("images/up.jpg"): FileImage(img),fit: BoxFit.cover
                  )

        ),
        //alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              img==null?Text(name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),):Text("")
            ],
          ),
        )
    );
  }
  upload(filename,) async {
    SharedPreferences pref= await SharedPreferences.getInstance();
    String token= pref.getString("api_token");
    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl),);
    //(filename);

    request.files.add(await http.MultipartFile.fromPath("", filename,),);
    final Map <String ,String> header= {

      'Accept': 'application/json',
      'authorization' : 'Bearer '+'$token',

    };
    request.headers.addAll(header);
    var res = await request.send();
    var response= await http.Response.fromStream(res);
    print('//ing...');
    var img=await json.decode(response.body)["imgurl"];
    print(img);
    print(response.body);
    return img;
  }
  uploadFront(String kyc, String cat, String front,String back)async{
    var res = await upload( front);
    var res2= await upload(back);
    print(res);
    print(cat);

    final result = await APIClient().uploadFront(kyc, cat, res,res2);
    print(result);


    if(result["status"]=="success"){
      _scaffoldkey.currentState.showSnackBar(APIClient.successToast(result["msg"]));

    }
    else{
      _scaffoldkey.currentState.showSnackBar(APIClient.errorToast(result["msg"]));

    }
  }
  uploadSingle(String kyc, String cat, String front)async{
    var res = await upload( front);
    //var res2= await upload(back);
    print(res);
    print(cat);

    final result = await APIClient().uploadFront(kyc, cat, res," ");
    print(result);


    if(result["status"]=="success"){
      _scaffoldkey.currentState.showSnackBar(APIClient.successToast(result["msg"]));

    }
    else{
      _scaffoldkey.currentState.showSnackBar(APIClient.errorToast(result["msg"]));

    }
  }
  uploadSelfie(String kyc, String cat, String filename)async{
    var res = await selfie(filename,);
    //var res2= await upload(back);
    print(res);
    print(cat);

    final result = await APIClient().uploadFront(kyc, cat, res," ");
    print(result);


    if(result["status"]=="success"){
      _scaffoldkey.currentState.showSnackBar(APIClient.successToast(result["msg"]));

    }
    else{
      _scaffoldkey.currentState.showSnackBar(APIClient.errorToast(result["msg"]));

    }
  }
  String selfieUrl="https://www.call2sex.com/api/KycApi/UploadSelfie";
  selfie(filename,) async {
    SharedPreferences pref= await SharedPreferences.getInstance();
    String token= pref.getString("api_token");
    var request = http.MultipartRequest('POST', Uri.parse(selfieUrl),);
    //(filename);

    request.files.add(await http.MultipartFile.fromPath("", filename,),);
    final Map <String ,String> header= {

      'Accept': 'application/json',
      'authorization' : 'Bearer '+'$token',

    };
    request.headers.addAll(header);
    var res = await request.send();
    var response= await http.Response.fromStream(res);
    print('//ing...');
    var img=await json.decode(response.body)["imgurl"];
    print(img);
    print(response.body);
    return img;
  }
}
