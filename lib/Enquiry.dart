import 'package:call2sex/Enquiry2.dart';
import 'package:call2sex/EnquiryOtp.dart';
import 'package:call2sex/Login.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'APIClient.dart';


class Enquiry extends StatefulWidget {
  @override
  _EnquiryState createState() => _EnquiryState();
}

class _EnquiryState extends State<Enquiry> {
  String lookingFor="Work";
  String interest="";
  String name="";
  String contact="";
  String type="";
  String user_type="";
  int selectedAddress=1;
  bool checkLoader=true;
  bool loginStatus=true;
  bool visible=false;
  bool showPassword=false;
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    //getAllContacts();
    super.initState();

    //userContact();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(key: _scaffolkey,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   onPressed: (){
      //     if(name==""){
      //       _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter Name"));
      //     }
      //     else if(contact==""){
      //       _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter Contact number"));
      //     }
      //     else if(lookingFor==""){
      //       _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select looking for"));
      //     }
      //     else if(interest==""){
      //       _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select your interest"));
      //     }
      //     else if(type==""){
      //       _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select your type"));
      //     }
      //     else{
      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>Enquiry2(
      //         name: name,
      //         contact: contact,
      //         lookingFor: lookingFor,
      //         interest: interest,
      //         type: type,
      //         user_type: user_type,
      //       )));
      //     }
      //   },
      //   tooltip: 'Next',
      //   child: Text("Next",style: TextStyle(color: Colors.black),),
      // ),
      
      //drawer: Drawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/logo.jpg"),fit: BoxFit.fill
          )
        ),
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.pink[900].withOpacity(0.5),
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                  Container(
                    height: 150,width: 200,
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         image:  AssetImage("images/1.png"),fit: BoxFit.fill
                    //     )
                    // ),
                  ),
                  Text("Send Enquiry ",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Looking for: ",style: TextStyle(color: Colors.white,fontSize: 17),),
                        new Radio(
                          value: 0,
                          groupValue: selectedAddress,
                          onChanged: (val){
                            setState(() {
                              selectedAddress=val;//(selectedAddress.toString());
                              lookingFor="Sex";
                              //(selectedAddress);
                            });
                          },
                          activeColor: Colors.white,
                        ),
                        new Text(
                          'Sex',
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
                              lookingFor="Work";
                              //(selectedAddress);
                            });
                          },
                          activeColor: Colors.white,
                        ),
                        new Text(
                          'Work',
                          style: new TextStyle(fontSize: 16.0,color: Colors.white),
                        ),
                      ],
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
                         // keyboardType: TextInputType.number,
                          onChanged: (val){
                          name=val;
                          },
                          decoration:InputDecoration(
                              icon: Icon(Icons.person,color: Colors.white,),
                              labelText: 'Name',
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
                          keyboardType: TextInputType.number,
                          onChanged: (val){
                          contact=val;
                          },
                          decoration:InputDecoration(
                            icon: Icon(Icons.phone_android,color: Colors.white,),
                              labelText: 'Contact',
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

                    child: Align(alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text("Submit"),
                          ),
                          onPressed: checkLoader?(){
                            if(name==""){
                              _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter name"));
                            }
                            else if(contact==""){
                              _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter Contact"));
                            }
                            else{
                              setState(() {
                                visible=true;
                                checkLoader=false;
                                //lookingFor==""?"Sex":lookingFor;
                              });
                              enquiry();
                            }
                          }:null,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5.0),
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
      )
    );
  }
  enquiry()async{
   // userContact();
    //(lookingFor);
    final body={
      "name":name,
      "contact":contact,
      "interested":lookingFor
    };
    final result= await APIClient().saveEnquiry(body);
    setState(() {
      checkLoader=true;
      visible=false;
    });
    if(result["status"]=="success"){

      Navigator.push(context, MaterialPageRoute(builder: (context)=>EnquiryOtp(
        mobile: contact,
      )));
    }
    else{
      setState(() {
        checkLoader=true;
        visible=false;
      });
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast(result["msg"]));
    }
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

}
