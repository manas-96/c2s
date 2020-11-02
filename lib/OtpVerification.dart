import 'package:call2sex/APIClient.dart';
import 'package:call2sex/Dashboard.dart';
import 'package:call2sex/WorkerList.dart';
import 'package:flutter/material.dart';

import 'Dashboard2.dart';


class OtpVerification extends StatefulWidget {
  final mobile;

  const OtpVerification({Key key, this.mobile}) : super(key: key);
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  bool visible=false;

  String otp="";

  bool showPassword=false;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldkey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/logo.jpg"),fit: BoxFit.fill
          ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color:Colors.blueGrey[900].withOpacity(0.9),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/20,),
                  Padding(
                    padding: const EdgeInsets.only(left:18.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,width: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:  AssetImage("images/1.png"),fit: BoxFit.fill
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Verify your OTP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/20,),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2,color: Colors.white)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextFormField(style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,

                          onChanged: (val){
                            otp=val;
                          },
                          decoration:InputDecoration(

                              icon: Icon(Icons.vpn_key_sharp,color: Colors.white,),
                              labelText: 'OTP',
                              labelStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none
                          ) ,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("Resend OTP",style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ),
                  SizedBox(height: 40,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: RaisedButton(
                        onPressed: (){
                          verify();
                          setState(() {
                            visible=true;
                          });
                        },
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text("Verify",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                        ),
                      ),
                    ),
                  ),
                  // Visibility(
                  //     maintainSize: true,
                  //     maintainAnimation: true,
                  //     maintainState: true,
                  //     visible: visible,
                  //     child: Container(
                  //         margin: EdgeInsets.only(top: 50, bottom: 30),
                  //         child: CircularProgressIndicator()
                  //     )
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  verify()async{
    if(otp==""){
      _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("enter otp"));

    }
    else{
      final result= await APIClient().otpVerification(widget.mobile, otp);
      if(result["status"]=="success"){
        _scaffoldkey.currentState.showSnackBar(APIClient.successToast("success"));
        if(result["data"][0]["user_type"]=="guest" || result["data"][0]["user_type"]=="Guest"){
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
      else{
        _scaffoldkey.currentState.showSnackBar(APIClient.errorToast(result["msg"]));
      }
    }
  }
}
