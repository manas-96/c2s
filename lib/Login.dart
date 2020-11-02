import 'dart:io';

import 'package:call2sex/Dashboard.dart';
import 'package:call2sex/Dashboard2.dart';
import 'package:call2sex/SignUp.dart';
import 'package:call2sex/WorkerList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'APIClient.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool visible=false;
  String mobile="";
  String password="";

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
                  image: AssetImage("images/screen.jpg"),fit: BoxFit.fill
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color:Colors.blueGrey[900].withOpacity(0.9),
                child: SafeArea(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/20,),
                      Container(
                        height: 100,width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:  AssetImage("images/1.png"),fit: BoxFit.fill
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Make a wish we will \nfulfill it for you.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
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
                                  icon: Icon(Icons.edit,color: Colors.white,),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none
                              ) ,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: RaisedButton(
                            onPressed: (){login();
                              setState(() {
                                visible=true;
                              });
                            },
                            color: Colors.white,
                            child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,),),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(width: MediaQuery.of(context).size.width,
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w300),),
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
                      Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: visible,
                          child: Container(
                              margin: EdgeInsets.only(top: 50, bottom: 30),
                              child: CircularProgressIndicator()
                          )
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
        _scaffoldkey.currentState.showSnackBar(APIClient.successToast("Please wait !"));

        final result = await APIClient().authRequest(mobile,password);
        print(result);
        setState(() {
          visible=false;
        });
        if( result["status"] == "failed" ){

          _scaffoldkey.currentState.showSnackBar(APIClient.errorToast(result["msg"].toString()));
          print(result["msg"].toString());
        } else {
          _scaffoldkey.currentState.showSnackBar(APIClient.successToast(result["msg"].toString()));
          print(result["msg"].toString());

          if(result["data"][0]["user_type"]=="guest"){
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard(

              )));
            });
          }
          else{
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard2(

              )));
            });
          }


        }

      } catch (e) {
        if(e==SocketException){ _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("Turn on mobile data"));}
        try{
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            _scaffoldkey.currentState.showSnackBar(
                APIClient.errorToast("Email or Password is wrong"));
          }
        }
        catch(e){
          _scaffoldkey.currentState.showSnackBar(APIClient.errorToast(e.toString()));
        }
      }

    }

  }
}
