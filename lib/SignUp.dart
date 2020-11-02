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
  String user_type="";
  bool visible=false;
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
              image: AssetImage("images/screen.jpg"),fit: BoxFit.fill
            ),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color:Colors.blueGrey[900].withOpacity(0.9),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height/20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Make a wish \nwe will fulfill it for you.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
                    ),
                   // SizedBox(height: MediaQuery.of(context).size.height/30,),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("joining as :",style: TextStyle(color: Colors.white,fontSize: 17),),
                          SizedBox(width: 10,),
                          Text(user_type,style: TextStyle(color: Colors.white,fontSize: 17),),
                          DropdownButton<String>(dropdownColor: Colors.white,
                            items: <String>['worker', 'guest', ].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(),),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                user_type= value;
                              });

                            },
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: RaisedButton(
                          onPressed: (){
                            register();
                            setState(() {
                              visible=true;
                            });
                          },
                          color: Colors.white,
                          child: Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                        ),
                      ),
                    ),
                    Container(width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text("By signing up you are agreed to our terms & condition",style: TextStyle(color: Colors.white,fontSize: 12),)
                    ),
                    Container(width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: visible,
                          child: Container(
                              margin: EdgeInsets.only(top: 50, bottom: 30),
                              child: CircularProgressIndicator()
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
          "ref_code":ref_code,
          "user_type":user_type,
          "contact" : mobile
        });
        setState(() {
          visible=false;
        });

        if( result["status"] == "failed" ){

          _scaffolkey.currentState.showSnackBar(APIClient.errorToast(result["msg"].toString()));
          print(result["message"].toString());
        } else {
          _scaffolkey.currentState.showSnackBar(APIClient.successToast(result["msg"].toString()));
          print(result["message"].toString());

          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OtpVerification(
              mobile: mobile.toString(),
            )));
          });


        }

      } catch (e) {
        _scaffolkey.currentState.showSnackBar(APIClient.errorToast(e.toString()));

      }

    }

  }
}
