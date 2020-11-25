import 'dart:io';

import 'package:call2sex/GuestBookingComplete.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'APIClient.dart';
import 'ChangePassword.dart';
import 'KYC.dart';
import 'Login.dart';
import 'Prime.dart';
import 'UploadVoter.dart';

class GuestProfile extends StatefulWidget {
  @override
  _GuestProfileState createState() => _GuestProfileState();
}

class _GuestProfileState extends State<GuestProfile> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String name="";
  String email="";
  String mobile="";
  String lastName="";
  String userId="";
  String uid="";
  String url="https://www.call2sex.com/api/GuestApi/UploadGuestSelfie";
  SharedPreferences sharedPreferences;
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
        //('No image selected.');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      name=  sharedPreferences.getString("firstname");
      lastName=  sharedPreferences.getString("lastname");
      email= sharedPreferences.getString("email");
      mobile=  sharedPreferences.getString("contact");
      userId= sharedPreferences.getString("id");
      uid= sharedPreferences.getString("uid");
      //mobile);      // will be null if never previously saved

      setState(() {});
    });
    fetchSelfie();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldkey,
//      appBar: AppBar(
//        elevation: 0,
//        title: Text("Profile"),
//        actions: <Widget>[
//          IconButton(icon: Icon(Icons.power_settings_new),
//            onPressed: (){
//            _onBackPressed();
//            },
//          )
//        ],
//      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,

        child: SingleChildScrollView(

          child: Column(
            children: <Widget>[
              Container(
              //  height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width,
                color: Colors.pink[900],

                child: SafeArea(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(),
                            IconButton(
                              icon: Icon(Icons.power_settings_new,color: Colors.white,),
                              onPressed: (){
                                _onBackPressed();
                              },
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 90,width: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: img!=null?NetworkImage("https://www.call2sex.com$img"):AssetImage("images/no.png"),fit: BoxFit.fill
                          )
                        ),
                      ),
                      SizedBox(height: 7,),
                      Text("$name"+" "+lastName,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text("Mob: $mobile",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w300),),
                      SizedBox(height: 5,),
                      Text("C2S ID: $uid",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w300),),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              //SizedBox(height: 10,),
             // SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing:15,childAspectRatio: 8/6),

                  children: [

                    InkWell(
                      child:  box(900, "Change Password",Icon(Icons.vpn_key_rounded,size: 40,color: Colors.white,)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));
                      },
                    ),
                    InkWell(
                      child: box(800, "Upload Image",Icon(Icons.camera_alt,size: 40,color: Colors.white,)),
                      onTap: (){
                        getImage();
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                      },
                    ),
                    InkWell(
                      child: box(700, "Upload KYC",Icon(Icons.home_repair_service,size: 40,color: Colors.white,)),
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadVoter()));
                      },
                    ),
                    InkWell(
                      child: box(600, "Payment Setting",Icon(Icons.payment,size: 40,color: Colors.white,)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>KYC()));
                      },
                    ),
                    InkWell(
                      child: box(500, "Earn Money",Icon(Icons.share,size: 40,color: Colors.white,)),
                      onTap:  () {
                        // A builder is used to retrieve the context immediately
                        // surrounding the RaisedButton.
                        //
                        // The context's `findRenderObject` returns the first
                        // RenderObject in its descendent tree when it's not
                        // a RenderObjectWidget. The RaisedButton's RenderObject
                        // has its position and size after it's built.
//                      final RenderBox box = context.findRenderObject();
                        final RenderBox box = context.findRenderObject();
                        Share.share("https://www.call2sex.com/\n"
                            "Refer your friend. Referral code $uid",
                            subject: "refer your friend. Referral code $uid ",
                            sharePositionOrigin:
                            box.localToGlobal(Offset.zero) &
                            box.size);
                      },
                    ),
                    InkWell(
                      child: box(400, "Support",Icon(Icons.support,size: 40,color: Colors.white,)),
                      onTap: (){
                        _launchURL();
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>KYC()));
                      },
                    ),
                    InkWell(
                      child: box(300, "Prime",Icon(Icons.account_balance_wallet_rounded,size: 40,color: Colors.white,)),
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Prime()));
                      },
                    ),

                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Log out from the application'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  //check?Navigator.pop(context):
                  logOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                },
              ),
            ],
          );
        });
  }
  logOut()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    pref.clear();
  }
  box(int num, String name, Icon icon){
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.pink[num].withOpacity(0.9)
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: 10,),
            Text(name,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
          ],
        )
    );
  }
  uploadImage(filename, url) async {
    SharedPreferences pref= await SharedPreferences.getInstance();
    String token= pref.getString("api_token");
    var request = http.MultipartRequest('POST', Uri.parse(url),);
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

    //(res.statusCode);
    //(res);
    return img;
  }
  upload()async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    String id=await preferences.getString("id");
    var res = await uploadImage(path, url);

    final result = await APIClient().SaveGuestSelfie(res);


    if(result["status"]=="success"){
      _scaffoldkey.currentState.showSnackBar(APIClient.successToast(result["msg"]));

    }
    else{
      _scaffoldkey.currentState.showSnackBar(APIClient.errorToast(result["msg"]));

    }
  }
  String img="";
  fetchSelfie()async{
    final result= await APIClient().fetchGuestSelfie();
    img=result["data"][0]["image"];
    print(img);
  }
  _launchURL() async {
    const url = 'https://api.whatsapp.com/send?phone=918016112117&text=Hi,%20I%20found%20you%20on%20Call2Sex%20App...';
    if (await canLaunch(url)) {

      await launch(url,forceSafariVC: false,
          forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

}
