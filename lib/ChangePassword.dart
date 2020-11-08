import 'dart:io';

import 'package:call2sex/Dashboard.dart';
import 'package:call2sex/Dashboard2.dart';
import 'package:call2sex/SignUp.dart';
import 'package:call2sex/WorkerList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'APIClient.dart';
import 'Enquiry.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  bool visible=false;
  String confirmPassword="";
  String oldPassword="";
  String newPassword="";
  bool checkLoader=true;
  bool ChangePasswordStatus=true;

  bool showPassword=false;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

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
    return GestureDetector(
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
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back,color: Colors.white,size: 30,))
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/20,),
                    Container(
                      height: 150,width: 150,
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
                            Text("Change your password",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)),
                            //Text("we will fulfill it for you",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)),
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
                            //keyboardType: TextInputType.number,
                            onChanged: (val){
                              oldPassword=val;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration:InputDecoration(
                                icon: Icon(Icons.vpn_key_rounded,color: Colors.white,),
                                labelText: ' Old Password',
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
                            //keyboardType: TextInputType.number,
                            onChanged: (val){
                              newPassword=val;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration:InputDecoration(
                                icon: Icon(Icons.vpn_key_outlined,color: Colors.white,),
                                labelText: ' New Password',
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
                              confirmPassword=val;
                            },
                            decoration:InputDecoration(
                                icon: Icon(Icons.vpn_key_outlined,color: Colors.white,),
                                labelText: ' Confirm Password',
                                labelStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none
                            ) ,
                          ),
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
                            if(newPassword==""){
                              _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("Enter your new password"));
                            }
                            else if(oldPassword==""){
                              _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("Enter old password"));
                            }

                            else if(confirmPassword==""){
                              _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("confirm your password"));

                            }
                            else if(confirmPassword!=newPassword){
                              _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("Both passwords are different"));

                            }
                            else{
                              changePassword();
                              setState(() {
                                visible=true;
                                checkLoader=false;
                              });
                            }

                          }:null,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text("ChangePassword",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,),),
                          ),
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
    );
  }
  changePassword()async{
    if(newPassword==""){
      _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("Enter your Mobile number"));
    }

    else if(confirmPassword==""){
      _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("Enter your password"));

    }
    else{
      try {
        //_scaffoldkey.currentState.showSnackBar(APIClient.successToast("Please wait !"));

        final result = await APIClient().changePassword(newPassword, oldPassword);
        print(result);
        setState(() {
          checkLoader=true;
          visible=false;
        });
        if( result["status"] == "failed" ){
          setState(() {
            ChangePasswordStatus=false;
          });
          print(ChangePasswordStatus);
          loader(result["msg"]);
          print(result["msg"].toString());
        } else {
          _scaffoldkey.currentState.showSnackBar(APIClient.successToast("Password changed successfully"));
          Navigator.pop(context);
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
            loader("Something wrong");
          }
        }
        catch(e){
          _scaffoldkey.currentState.showSnackBar(APIClient.errorToast(e.toString()));
        }
      }

    }

  }
}
