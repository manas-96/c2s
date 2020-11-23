import 'package:call2sex/ChangePassword.dart';
import 'package:call2sex/ServiceSetting.dart';
import 'package:call2sex/WorkerSaveInfo.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'KYC.dart';
import 'Login.dart';

class WorkerProfile extends StatefulWidget {
  @override
  _WorkerProfileState createState() => _WorkerProfileState();
}

class _WorkerProfileState extends State<WorkerProfile> {
  String name="";
  String email="";
  String mobile="";
  String lastName="";
  String userId="";
  String uid="";
  String image="";
  SharedPreferences sharedPreferences;


  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
     // print(sharedPreferences.getString("contact"));
      name=  sharedPreferences.getString("firstname");
      lastName=  sharedPreferences.getString("lastname");
      email= sharedPreferences.getString("email");
      mobile=  sharedPreferences.getString("contact");
      userId= sharedPreferences.getString("id");
      uid= sharedPreferences.getString("uid");
      image=sharedPreferences.getString("image");
      //mobile);
     // print(mobile+"mobile");
      print(sharedPreferences.getString("id"));
      setState(() {});

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(elevation: 0,
        title: Text("Profile"),
        backgroundColor: Colors.pink[900],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:10.0),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.power_settings_new,color: Colors.white,),
                onPressed: (){
                  _onBackPressed();
                },
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                //  height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width,
                color: Colors.pink[900],

                child: SafeArea(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(height: 10,),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: image==""?Icon(Icons.person,color: Colors.pink[900],):
                        Container(height: 90,width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage("https://www.call2sex.com/${image.toString().replaceFirst('~', '')}"),fit: BoxFit.fill
                            )
                          ),
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
              SizedBox(height: 10,),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing:15,childAspectRatio: 8/6),

                  children: [


                    InkWell(
                      child: box(900, "Upload Details",Icon(Icons.details,size: 40,color: Colors.white,)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerSaveInfo()));
                      },
                    ),
                    InkWell(
                      child: box(800, "Rate Setting",Icon(Icons.home_repair_service,size: 40,color: Colors.white,)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceSetting()));
                      },
                    ),
                    InkWell(
                      child: box(700, "Payment Setting",Icon(Icons.payment,size: 40,color: Colors.white,)),
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>KYC()));
                      },
                    ),
                    InkWell(
                      child:  box(600, "Change Password",Icon(Icons.vpn_key_rounded,size: 40,color: Colors.white,)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));
                      },
                    ),
                    InkWell(
                      child: box(500, "Earn Money",Icon(Icons.share,size: 40,color: Colors.white,)),
                      onTap:  () {

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

                  ],
                ),
              )

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
