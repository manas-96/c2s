import 'dart:io';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'KYC.dart';
import 'Login.dart';

class GuestProfile extends StatefulWidget {
  @override
  _GuestProfileState createState() => _GuestProfileState();
}

class _GuestProfileState extends State<GuestProfile> {
  String name="";
  String email="";
  String mobile="";
  String lastName="";
  String userId="";
  String uid="";
  SharedPreferences sharedPreferences;
  File _image;

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
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width,
                color: Colors.blueGrey[900],

                child: SafeArea(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back,color: Colors.white,),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
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
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person),
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
              SizedBox(height: 10,),
              SizedBox(height: 10,),

              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: 5,right: 5),
                child: Card(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text("Change Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                        Divider(thickness: 1,),
                        GestureDetector(
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword(
                              //   userId: userId.toString(),
                              // )));
                            },
                            child: Text("View details",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.blueGrey[900],fontSize: 16),)),
                        SizedBox(height: 2,)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: 5,right: 5),
                child: Card(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text("Upload selfie",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                        Divider(thickness: 1,),
                        GestureDetector(
                            onTap: (){
                              //getImage();
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Address()));
                            },
                            child: Text("View details",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.blueGrey[900],fontSize: 16),)),
                        SizedBox(height: 2,)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: 5,right: 5),
                child: Card(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text("Upload KYC",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                        Divider(thickness: 1,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>KYC()));

                          },
                          child: Text("View details",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.blueGrey[900],fontSize: 16),),
                        ),
                        SizedBox(height: 2,)
                      ],
                    ),
                  ),
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
}
