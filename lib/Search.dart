import 'package:call2sex/SearchResult.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    _getStateList();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        title: Text("Search"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.pink),
                color:  Colors.white,
              ),
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              //color:  Colors.pink[900],
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
                            color: Colors. black,
                            fontSize: 16,
                          ),
                          hint: Text('Select State',style: TextStyle(color: Colors.black)),
                          onChanged: (String newValue) {
                            setState(() {
                              _myState = newValue;
                              city=[];
                              distsList=[];
                              pinList=[];
                              _mycity=null;
                              _pin=null;
                              _mydist=null;
                              _getdistsList();
                              //(_myState);
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
          ),


          //======================================================== dist

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.pink),
                color:   Colors.white,
              ),
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              //color:  Colors.pink[900],
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
                            color: Colors. black,
                            fontSize: 16,
                          ),
                          hint: Text('Select dist',style: TextStyle(color: Colors.black),),
                          onChanged: (String newValue) {
                            setState(() {
                              _mydist = newValue;
                              city=[];
                              pinList=[];
                              _mycity=null;
                              _pin=null;
                              _getcityList();
                              //(_mydist);
                            });
                          },
                          items: distsList?.map((item) {
                            return new DropdownMenuItem(
                              child:  Text(item['dist_name']),
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.pink),
                color:  Colors.white,
              ),
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),

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
                            color: Colors. black,
                            fontSize: 16,
                          ),
                          hint: Text('Select city',style: TextStyle(color: Colors.black)),
                          onChanged: (String newValue) {
                            setState(() {
                              _mycity = newValue;
                              pinList=[];
                              _pin=null;
                              _getpinList();
                              //(_mycity);
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
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              //color:  Colors.pink[900],
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.pink),
                color:  Colors.white,
              ),
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
                            color: Colors. black,
                            fontSize: 16,
                          ),
                          hint: Text('Select Pincode',style: TextStyle(color: Colors.black),),
                          onChanged: (String newValue) {
                            setState(() {
                              _pin = newValue;
                              _getcityList();
                              //(_pin);
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
          ),
          SizedBox(height: 40,),
          Padding(
            padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/4,right: MediaQuery.of(context).size.width/4),
            child: RaisedButton(
              color: Colors.pink[900],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height:40,child: Center(child: Text("Search",style: TextStyle(color: Colors.white,fontSize: 18),))),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchResult(
                  state: _myState.toString(),
                  dist: _mydist.toString(),
                  city: _mycity.toString(),
                  pin: _pin.toString(),
                )));
              },
            ),
          ),
        ],
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

//      //(data);
      setState(() {
        statesList = data['data'];
      });
    });
  }
  List distsList;
  String _mydist;

  String distInfoUrl =
      '';
  Future<String> _getdistsList() async {
    await http.get("https://www.call2sex.com/api/EnquiryApi/FetchbyState?state_id=$_myState", headers: {
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
}
