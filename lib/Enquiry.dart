import 'package:call2sex/Enquiry2.dart';
import 'package:call2sex/Login.dart';
import 'package:flutter/material.dart';

import 'APIClient.dart';


class Enquiry extends StatefulWidget {
  @override
  _EnquiryState createState() => _EnquiryState();
}

class _EnquiryState extends State<Enquiry> {
  String lookingFor="";
  String interest="";
  String name="";
  String contact="";
  String type="";
  String user_type="";
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(key: _scaffolkey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: (){
          if(name==""){
            _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter Name"));
          }
          else if(contact==""){
            _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter Contact number"));
          }
          else if(lookingFor==""){
            _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select looking for"));
          }
          else if(interest==""){
            _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select your interest"));
          }
          else if(type==""){
            _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select your type"));
          }
          else{
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Enquiry2(
              name: name,
              contact: contact,
              lookingFor: lookingFor,
              interest: interest,
              type: type,
              user_type: user_type,
            )));
          }
        },
        tooltip: 'Next',
        child: Text("Next",style: TextStyle(color: Colors.black),),
      ),
      appBar: AppBar(
        actions: [
          Center(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              },
              child: Text("Login     ",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
          )
        ],
        backgroundColor: Colors.blueGrey[900],
        title: Text("Enquiry"),
      ),
      drawer: Drawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/screen.jpg"),fit: BoxFit.fill
          )
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.blueGrey[900].withOpacity(0.7),
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40,),
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
                            //icon: Icon(Icons.person,color: Colors.white,),
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
                          //icon: Icon(Icons.person,color: Colors.white,),
                            labelText: 'Contact',
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
                      child:  Row(
                        children: [
                          Text("You are here for :",style: TextStyle(color: Colors.white,fontSize: 17),),
                          SizedBox(width: 10,),
                          Text(lookingFor,style: TextStyle(color: Colors.white,fontSize: 17),),
                          DropdownButton<String>(dropdownColor: Colors.white,
                            iconSize: 30,
                            icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                            items: <String>['Sex', 'Work', ].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(),),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                lookingFor= value;
                              });
                            },
                          ),
                        ],
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
                      child:  Row(
                        children: [
                          Text("Interest in :",style: TextStyle(color: Colors.white,fontSize: 17),),
                          SizedBox(width: 10,),
                          Text(interest,style: TextStyle(color: Colors.white,fontSize: 17),),
                          DropdownButton<String>(dropdownColor: Colors.white,
                            iconSize: 30,
                            icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                            items: <String>['Girl', 'Boy','Gay','Lesbo' ].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(),),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                interest= value;
                              });
                            },
                          ),
                        ],
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
                      child:  Row(
                        children: [
                          Text("Type :",style: TextStyle(color: Colors.white,fontSize: 17),),
                          SizedBox(width: 10,),
                          Text(type,style: TextStyle(color: Colors.white,fontSize: 17),),
                          DropdownButton<String>(dropdownColor: Colors.white,
                            iconSize: 30,
                            icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                            items: <String>['sex shorts','Hour', 'Night','24 hours','tour','group' ].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(),),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                type= value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

}
