import 'dart:io';

import 'package:call2sex/Dashboard.dart';
import 'package:call2sex/Dashboard2.dart';
import 'package:call2sex/ForgotPassword.dart';
import 'package:call2sex/SignUp.dart';
import 'package:call2sex/WorkerList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'APIClient.dart';
import 'Enquiry.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool visible=false;
  String mobile="";
  String password="";
  bool checkLoader=true;
  bool loginStatus=true;

  bool showPassword=false;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
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
  Future<bool> loader(String msg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(msg),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Text("OK"),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              )

            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onBackPressed,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(key: _scaffoldkey,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/logo.jpg"),fit: BoxFit.fill
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color:Colors.pink[900].withOpacity(0.5),
                child: SafeArea(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left:12.0),
                            child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Enquiry()));
                                },
                                child: Icon(Icons.home,color: Colors.white,size: 30,))
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/20,),
                      Container(
                        height: 150,width: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:  AssetImage("images/1.png"),fit: BoxFit.fill
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:18.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Make a wish",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)),
                              Text("we will fulfill it for you",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/20,),
                      //Text("  Looking for a perfect night then Sign up,",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w300),)

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 2,color: Colors.white)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (val){
                                mobile=val;
                              },
                              style: TextStyle(color: Colors.white),
                              decoration:InputDecoration(
                                  icon: Icon(Icons.phone_android,color: Colors.white,),
                                  labelText: 'Mobile',
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none
                              ) ,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 2,color: Colors.white)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),

                              onChanged: (val){
                                password=val;
                              },
                              decoration:InputDecoration(
                                  icon: Icon(Icons.vpn_key_rounded,color: Colors.white,),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none
                              ) ,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Forget password ?",
                              style: TextStyle(color: Colors.yellow,fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: visible,
                          child: Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              child: CircularProgressIndicator()
                          )
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: RaisedButton(
                            onPressed: checkLoader?(){
                              if(mobile==""){
                                _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("Enter your Mobile number"));
                              }

                              else if(password==""){
                                _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("Enter your password"));

                              }else{
                                login();
                                setState(() {
                                  visible=true;
                                  checkLoader=false;
                                });
                              }

                            }:null,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,),),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(width: MediaQuery.of(context).size.width,
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w300),),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                                },
                                child: Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  login()async{
    if(mobile==""){
      _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("Enter your Mobile number"));
    }

    else if(password==""){
      _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("Enter your password"));

    }
    else{
      try {
        //_scaffoldkey.currentState.showSnackBar(APIClient.successToast("Please wait !"));

        final result = await APIClient().authRequest(mobile,password);
        //print(result);
        setState(() {
          checkLoader=true;
          visible=false;
        });
        if( result["status"] == "failed" ){
          setState(() {
            loginStatus=false;
          });
          print(loginStatus);
          loader(result["msg"]);
          print(result["msg"].toString());
        } else {

          if(result["data"][0]["user_type"]=="guest" || result["data"][0]["user_type"]=="Guest"){
            Future.delayed(const Duration(seconds: 0), () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard(
              )));
            });
          }
          else{
            Future.delayed(const Duration(seconds: 0), () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard2()));
            });
          }
        }

      } catch (e) {
        setState(() {
          checkLoader=true;
          visible=false;
        });
        if(e==SocketException){ loader("Turn on mobile data");}
        try{
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            loader("User ID or Password is wrong");
          }
        }
        catch(e){
          _scaffoldkey.currentState.showSnackBar(APIClient.errorToast(e.toString()));
        }
      }

    }

  }
}
