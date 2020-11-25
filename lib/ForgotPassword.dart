import 'package:flutter/material.dart';

import 'APIClient.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool checkLoader=true;
  bool loginStatus=true;
  bool visible=false;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String mobile="";
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
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color:Colors.pink[900].withOpacity(0.5),
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
                              height: 150,width: 200,
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
                      child: Text("Forgot your password?",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
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
                              mobile=val;
                            },
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
                    SizedBox(height: 20,),
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
                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: RaisedButton(
                          onPressed: (){
                            if(mobile==""){
                              _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("enter mobile number"));
                            }
                            else{
                              verify();
                              setState(() {
                                visible=true;
                                checkLoader=false;
                              });
                            }
                          },
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text("Send",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
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
      ),
    );
  }
  verify()async{
    if(mobile==""){
      _scaffoldkey.currentState.showSnackBar(APIClient.errorToast("enter mobile number"));

    }
    else{
      final result= await APIClient().forgotPassword(mobile);
      setState(() {
        checkLoader=true;
        visible=false;
      });
      if(result["status"]=="success"){
        print(result);
        _scaffoldkey.currentState.showSnackBar(APIClient.successToast("Password sent to your registered number"));

        }
      else{
        setState(() {
          loginStatus=false;
          checkLoader=true;
          visible=false;
        });
        _scaffoldkey.currentState.showSnackBar(APIClient.errorToast(result["msg"]));


      }
      }




  }
}
