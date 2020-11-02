import 'package:call2sex/APIClient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart'as http;
import 'dart:convert';
class Enquiry2 extends StatefulWidget {
  final name;
  final contact;
  final type;
  final lookingFor;
  final interest;
  final user_type;

  const Enquiry2({Key key, this.name, this.contact, this.type, this.lookingFor, this.interest, this.user_type}) : super(key: key);
  @override
  _Enquiry2State createState() => _Enquiry2State();
}

class _Enquiry2State extends State<Enquiry2> {
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();

  String landmark="";
  String pin="";
  @override
  void initState() {
    // TODO: implement initState
    _getStateList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffolkey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text("Enquiry"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blueGrey[900],
        child: SingleChildScrollView(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              //======================================================== State

              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                color:  Colors.blueGrey[900],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: _myState,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors. blueGrey,
                              fontSize: 16,
                            ),
                            hint: Text('Select State',style: TextStyle(color: Colors.white)),
                            onChanged: (String newValue) {
                              setState(() {
                                _myState = newValue;
                                _getdistsList();
                                print(_myState);
                              });
                            },
                            items: statesList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['state_name']),
                                value: item['state_id'].toString(),
                              );
                            })?.toList() ??
                                [],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              //======================================================== dist

              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                color:  Colors.blueGrey[900],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: _mydist,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors. blueGrey,
                              fontSize: 16,
                            ),
                            hint: Text('Select dist',style: TextStyle(color: Colors.white),),
                            onChanged: (String newValue) {
                              setState(() {
                                _mydist = newValue;
                                _getcityList();
                                print(_mydist);
                              });
                            },
                            items: distsList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['dist_name']),
                                value: item['dist_id'].toString(),
                              );
                            })?.toList() ??
                                [],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                color: Colors.blueGrey[900],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: _mycity,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors. blueGrey,
                              fontSize: 16,
                            ),
                            hint: Text('Select city',style: TextStyle(color: Colors.white)),
                            onChanged: (String newValue) {
                              setState(() {
                                _mycity = newValue;
                                _getpinList();
                                print(_mycity);
                              });
                            },
                            items: city?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['city_name']),
                                value: item['city_id'].toString(),
                              );
                            })?.toList() ??
                                [],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                color:  Colors.blueGrey[900],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: _pin,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors. blueGrey,
                              fontSize: 16,
                            ),
                            hint: Text('Select Pincode',style: TextStyle(color: Colors.white),),
                            onChanged: (String newValue) {
                              setState(() {
                                _pin = newValue;
                                _getcityList();
                                print(_pin);
                              });
                            },
                            items: pinList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['pin_code']),
                                value: item['pin_id'].toString(),
                              );
                            })?.toList() ??
                                [],
                          ),
                        ),
                      ),
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
                        landmark=val;
                      },
                      decoration:InputDecoration(
                        //icon: Icon(Icons.person,color: Colors.white,),
                          labelText: 'Landmark',
                          labelStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none
                      ) ,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  onPressed: (){
                    submit();
                  },
                  child: Center(
                    child: Text("Submit"),
                  ),
                ),
              )
            ],
          ),
        )
        ),

    );
  }
  List statesList;
  String _myState;

  String stateInfoUrl = 'https://www.call2sex.com/api/EnquiryApi/FetchbyCountry';
  Future<String> _getStateList() async {
    await http.get(stateInfoUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, ).then((response) {
      var data = json.decode(response.body);

//      print(data);
      setState(() {
        statesList = data['data'];
      });
    });
  }

  // Get State information by API
  List distsList;
  String _mydist;

  String distInfoUrl =
      '';
  Future<String> _getdistsList() async {
    await http.get("https://www.call2sex.com/api/EnquiryApi/FetchbyState?state_id=11", headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, ).then((response) {
      var data = json.decode(response.body);

      setState(() {
        distsList = data['data'];
      });
    });
  }
  List city;
  String _mycity;
  Future<String> _getcityList() async {
    await http.get("https://www.call2sex.com/api/EnquiryApi/FetchbyDist?dist_id=$_mydist", headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, ).then((response) {
      var data = json.decode(response.body);

      setState(() {
        city = data['data'];
      });
    });
  }
  List pinList;
  String _pin;
  Future<String> _getpinList() async {
    await http.get("https://www.call2sex.com/api/EnquiryApi/FetchbyCity?city_id=$_mycity", headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, ).then((response) {
      var data = json.decode(response.body);
      if(data["status"]=="failed"){
        setState(() {
          pinList=['No data'];
        });
      }
      setState(() {
        pinList = data['data'];
      });
    });
  }
  submit()async{
    final body={
      "name":widget.name,
      "contact":widget.contact,
      "email":"test@gmail.com",
      "city_id":_mycity,
      "dist_id":_mydist,
      "state_id":_myState,
      "pin_id":_pin.toString(),
      "location":landmark,
      "user_type":widget.lookingFor
    };

    final response = await http.post("https://www.call2sex.com/api/EnquiryApi/SaveEnquiry",body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      print(resData);
      if(resData["status"]=="success"){
        _scaffolkey.currentState.showSnackBar(APIClient.successToast(resData["msg"]));
      }
      else{
        _scaffolkey.currentState.showSnackBar(APIClient.errorToast(resData["msg"]));

      }
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }

}
