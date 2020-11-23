import 'dart:io';
import 'dart:math';
import 'package:call2sex/Dashboard.dart';
import 'package:call2sex/Dashboard2.dart';
import 'package:call2sex/Enquiry.dart';
import 'package:call2sex/Login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';



class animationPage extends StatefulWidget {
  @override
  _animationPageState createState() => _animationPageState();
}

class _animationPageState extends State<animationPage> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  Animation<double> animation;
  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("id"));
    if(sharedPreferences.getString("id") == null) {
      //sharedPreferences.getString("userId"));
      //APIClient().authRequest(sharedPreferences.getString("email"), sharedPreferences.getString("pass"));
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Enquiry()), (Route<dynamic> route) => false);
    }else{
      if(sharedPreferences.getString("user_type")=="guest" || sharedPreferences.getString("user_type")=="Guest")
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
        }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard2()));
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController=AnimationController(duration: Duration(seconds: 2),vsync: this);
    animation=Tween<double>(
      begin: 0,
      end: 0,
    ).animate(animationController)
      ..addListener((){
        setState(() {

        });
      })
      ..addStatusListener((status){
        if(animationController.isCompleted){
          setState(() {
            checkLoginStatus();
          });
        }
        else if(animationController.isDismissed){
          animationController.forward();
        }
      });
    animationController.forward();
    //checkLoginStatus();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.rotate(
        angle: animation.value,
        child: Center(
          child: Container(

              alignment: Alignment.center,
              padding: EdgeInsets.all(30),
              child: Image.asset("images/1.png",fit: BoxFit.cover,)
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
}
