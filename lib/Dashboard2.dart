import 'dart:io';

import 'package:call2sex/APIClient.dart';
import 'package:call2sex/UploadGallery.dart';
import 'package:call2sex/WorkerBookingHistory.dart';
import 'package:call2sex/WorkerProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';
import 'Wallet.dart';


class Dashboard2 extends StatefulWidget {
  @override
  _Dashboard2State createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  int _currentIndex = 0;
  String name="";
  String lastName="";
  String image="";
  SharedPreferences sharedPreferences;
  bool _switchValue=true;
  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
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
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
            ],
          );
        });
  }
  Future<bool> logout() {
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    preferences.getKeys();
    for(String key in preferences.getKeys()) {
        preferences.remove(key);
    }
   // print(pref.getString("id"));
  }

  String uid="";
  @override
  void initState() {
    getInfo();
    // TODO: implement initState
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      name=  sharedPreferences.getString("firstname");
      lastName=  sharedPreferences.getString("lastname");
      image=sharedPreferences.getString("image");
      uid= sharedPreferences.getString("uid");
      //mobile);
      //(image);
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onBackPressed,
     child: Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.pink[500],
         title: Text("Home"),
         actions: [
           Padding(
             padding: const EdgeInsets.only(right:10.0),
             child: Center(
               child: IconButton(
                 icon: Icon(Icons.power_settings_new,color: Colors.white,),
                 onPressed: (){
                  logout();
                 },
               ),
             ),
           ),
         ],
       ),
       body: Container(
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView(
             children: [
               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Container(
                   width: MediaQuery.of(context).size.width,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Container(
                         height: 180,width: 180,
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           border: Border.all(width: 2,color: Colors.purple[300]),
                           image: DecorationImage(
                               image: img==null?AssetImage("images/female.png"):NetworkImage("https://www.call2sex.com/${img.toString()}"),fit: BoxFit.fill
                           )
                         ),
                       ),
                       Container(
                         child: Text("Hi ! $name",style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 18),),
                       ),
                       Container(
                         child: Text("C2S ID: $uid",style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 18),),
                       ),

                     ],
                   ),
                 ),
               ),
               SizedBox(height: 20,),
               GridView(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5),

                 children: [

                   InkWell(
                     child:  box(900, "Profile"),
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerProfile(
                         img: img,
                       )));
                     },
                   ),
                   InkWell(
                     child: box(800, "Gallery"),
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
                     },
                   ),
                   InkWell(
                     child: box(700, "Bookings"),
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerBookingHistory()));
                     },
                   ),

                   InkWell(
                     child: box(400, "Wallet"),
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Wallet()));
                     },
                   ),
                 ],
               )
             ],
           ),
         ),
       ),
     ),
    );
  }
  box(int num, String name){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.pink[num].withOpacity(0.9)
      ),
      child: Center(
        child: Text(name,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
      ),
    );
  }
  String img;
  getInfo()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    String id=pref.getString("id");
    final res= await APIClient().fetchWorkerInfo(id);
    if(res["status"]=="success"){
      //(res["data"]);
      setState(() {
        img=res["data"][0]["image"];
        print(img);
      });
    }
  }
}
