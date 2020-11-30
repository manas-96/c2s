import 'package:call2sex/Enquiry.dart';
import 'package:call2sex/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'APIClient.dart';
import 'OtpVerification.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String mobile="";
  String ref_code="";
  String firstname="";
  String lastname="";
  String user_type="Guest";
  int selectedAddress=1;


  bool checkLoader=true;
  bool loginStatus=true;
  bool visible=false;



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
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
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
    return GestureDetector(onTap: (){
      FocusScope.of(context).unfocus();
    },
      child: Scaffold(key: _scaffolkey,
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
              child: SingleChildScrollView(//physics: NeverScrollableScrollPhysics(),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
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
                    //SizedBox(height: MediaQuery.of(context).size.height/30,),
                    Padding(
                      padding: const EdgeInsets.only(left:18.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 150,width: 200,
                              // decoration: BoxDecoration(
                              //     image: DecorationImage(
                              //         image:  AssetImage("images/1.png"),fit: BoxFit.fill
                              //     )
                              // ),
                            ),
                          ],
                        ),
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

                   // SizedBox(height: MediaQuery.of(context).size.height/30,),

                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Register as: ",style: TextStyle(color: Colors.white,fontSize: 17),),
                          new Radio(
                            value: 0,
                            groupValue: selectedAddress,
                            onChanged: (val){
                              setState(() {
                                selectedAddress=val;//(selectedAddress.toString());
                                user_type="Worker";
                              });
                            },
                            activeColor: Colors.white,
                          ),
                          new Text(
                            'Worker',
                            style: new TextStyle(
                              fontSize: 16.0,color: Colors.white
                            ),
                          ),
                          new Radio(
                            value: 1,
                            groupValue: selectedAddress,
                            onChanged: (value){
                              setState(() {
                                selectedAddress=value;
                                user_type="Guest";
                              });
                            },
                            activeColor: Colors.white,
                          ),
                          new Text(
                            'Guest',
                            style: new TextStyle(fontSize: 16.0,color: Colors.white),
                          ),
                        ],
                      ),
                    ),



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
                            style: TextStyle(color: Colors.white),
                            onChanged: (val){
                              firstname=val;
                            },
                            decoration:InputDecoration(
                                icon: Icon(Icons.person,color: Colors.white,),
                                labelText: 'First Name',
                                labelStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
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
                              lastname=val;
                            },
                            decoration:InputDecoration(
                              icon: Icon(Icons.person,color: Colors.white,),
                              labelText: 'Last Name',
                              labelStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2,color: Colors.white)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextFormField(style: TextStyle(color: Colors.white),
                            onChanged: (val){
                              ref_code=val;
                            },
                            decoration:InputDecoration(
                                icon: Icon(Icons.edit,color: Colors.white,),
                                labelText: 'Referral code (optional)',
                                labelStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none
                            ) ,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),
                    Container(width: MediaQuery.of(context).size.width,

                      alignment: Alignment.center,
                      child: Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: visible,
                          child: Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: CircularProgressIndicator()
                          )
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: RaisedButton(
                          onPressed: (){
                            if(user_type==""){
                              _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select user type"));
                            }
                            else if(user_type==""){
                              _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select user type"));

                            }
                            else if(firstname==""){
                              _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter your first name "));

                            }
                            else if(lastname==""){
                              _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter your Last name"));

                            }
                            // else if(email==""){
                            //   _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter your email"));
                            //
                            // }
                            else if(mobile==""){
                              _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter your Mobile number"));

                            }
                            else{

                            }
                            register();
                            setState(() {
                              checkLoader?visible=true:null;
                              checkLoader? checkLoader=false:null;
                            });
                          },
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:5.0,bottom: 15),
                      child: Container(width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?  ",style: TextStyle(color: Colors.white,fontSize: 14),),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                              },
                              child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 16),),
                            )
                          ],
                        )
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
  register()async{
    if(user_type==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select user type"));
    }
    else if(user_type==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select user type"));

    }
    else if(firstname==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter your first name "));

    }
    else if(lastname==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter your Last name"));

    }
    // else if(email==""){
    //   _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter your email"));
    //
    // }
    else if(mobile==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter your Mobile number"));

    }
    // else if(password==""){
    //   _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter your Password"));
    //
    // }
    else{
      setState(() {
        visible=false;
      });
      try {
        _scaffolkey.currentState.showSnackBar(APIClient.successToast("please wait!"));

        final result = await APIClient().signUP({
          "firstname": firstname,
          "lastname":lastname,
          "ref_code":ref_code.toUpperCase(),
          "user_type":user_type,
          "contact" : mobile
        });
        print(result);
        setState(() {
          checkLoader=true;
          visible=false;
        });

        if( result["status"] == "failed" ){
          setState(() {
            checkLoader=true;
            visible=false;
          });
          _scaffolkey.currentState.showSnackBar(APIClient.errorToast(result["msg"].toString()));
          //(result["message"].toString());
        } else {
          _scaffolkey.currentState.showSnackBar(APIClient.successToast(result["msg"].toString()));
          //(result["message"].toString());

            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OtpVerification(
              mobile: mobile.toString(),
              name: "$firstname $lastname",
              fockOtp: result["otp"],
            )));



        }

      } catch (e) {
        setState(() {
          checkLoader=true;
          visible=false;
        });
        _scaffolkey.currentState.showSnackBar(APIClient.errorToast(e.toString()));

      }

    }

  }
}
