import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'APIClient.dart';
class WorkerSaveInfo extends StatefulWidget {
  @override
  _WorkerSaveInfoState createState() => _WorkerSaveInfoState();
}

class _WorkerSaveInfoState extends State<WorkerSaveInfo> {
  bool visible=false;
  String interested="Men";
  int interestValue=1;
  bool _switchValue=true;
  int selectedAddress=1;
  String gender="female";
  String age="";
  String address="";
  String h="";
  String w="";
  String c="";
  String shareableno="";
  String username="";
  String about="";
  String url="https://www.call2sex.com/api/WorkerApi/UploadProfileImage";
  File _image;
  var path;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        path=_image.path;
        //upload();
        //uploadImage(path,url);
      } else {
        //('No image selected.');
      }
    });
  }
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    _getStateList();
    fetchInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffolkey,
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        title: Text("Upload Details"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 180,width: 180,
                    decoration: BoxDecoration(

                      shape: BoxShape.circle,
                      border: Border.all(width: 2,color: Colors.purple[300]),
                      image: DecorationImage(
                        image: _image==null?NetworkImage(url):FileImage(_image),fit: BoxFit.fill
                      )
                    ),
                    //alignment: Alignment.bottomRight,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 2,
                          bottom: 2,
                          child: IconButton(
                            icon: Icon(Icons.photo_camera,color: Colors.pink,),
                            onPressed: (){
                              getImage();
                            },
                          ),
                        ),
                        _image==null?
                        Positioned(
                          left: 60,
                            top: 78,
                            child: Text("No Image")):
                        Text("")
                      ],
                    )
                ),
                Text(""),
              ],
            ),
            SizedBox(height: 10,),
            Container(width: MediaQuery.of(context).size.width,
              child: Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Availability status"),

                  CupertinoSwitch(
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Gender: ",style: TextStyle(color: Colors.black,fontSize: 17),),
                  new Radio(
                    value: 0,
                    groupValue: selectedAddress,
                    onChanged: (val){
                      setState(() {
                        selectedAddress=val;//(selectedAddress.toString());
                        gender="male";
                        //(gender);
                      });
                    },
                    activeColor: Colors.pink[900]
                  ),
                  new Text(
                    'Male',
                    style: new TextStyle(
                        fontSize: 16.0,color: Colors.black
                    ),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: selectedAddress,
                    onChanged: (value){
                      setState(() {
                        selectedAddress=value;
                        gender="female";
                        //(gender);
                      });
                    },
                    activeColor: Colors.pink[900],
                  ),
                  new Text(
                    'Female',
                    style: new TextStyle(fontSize: 16.0,color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Interested: ",style: TextStyle(color: Colors.black,fontSize: 17),),
                  new Radio(
                      value: 0,
                      groupValue: interestValue,
                      onChanged: (val){
                        setState(() {
                          interestValue=val;//(interestValue.toString());
                          interested="Women";
                          //(interested);
                        });
                      },
                      activeColor: Colors.pink[900]
                  ),
                  new Text(
                    'Women',
                    style: new TextStyle(
                        fontSize: 16.0,color: Colors.black
                    ),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: interestValue,
                    onChanged: (value){
                      setState(() {
                        interestValue=value;
                        interested="Men";
                        //(interested);
                      });
                    },
                    activeColor: Colors.pink[900],
                  ),
                  new Text(
                    'Men',
                    style: new TextStyle(fontSize: 16.0,color: Colors.black),
                  ),
                ],
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2,color: Colors.pink)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(style: TextStyle(color: Colors.black),
                    //keyboardType: TextInputType.number,
                    onChanged: (val){
                      username=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'User Name',
                        // hintText: "Example 54",
                        labelStyle: TextStyle(color: Colors.black),
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
                    border: Border.all(width: 2,color: Colors.pink)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(style: TextStyle(color: Colors.black),
                    // keyboardType: TextInputType.number,
                    onChanged: (val){
                      address=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'Location',
                        labelStyle: TextStyle(color: Colors.black),
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
                    border: Border.all(width: 2,color: Colors.pink)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      age=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'Age',
                        hintText: ' ${age=="null"?" ":age}',
                        labelStyle: TextStyle(color: Colors.black),
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
                    border: Border.all(width: 2,color: Colors.pink)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(style: TextStyle(color: Colors.black),
                     keyboardType: TextInputType.number,
                    onChanged: (val){
                      h=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'Height(in ft.)',
                        hintText: " ${h=="null"?"Example 5.5":h}",
                        labelStyle: TextStyle(color: Colors.black),
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
                    border: Border.all(width: 2,color: Colors.pink)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      w=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'Weight(in kg)',
                        hintText: " ${w=="null"?"Example 54":w}",
                        labelStyle: TextStyle(color: Colors.black),
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
                    border: Border.all(width: 2,color: Colors.pink)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(style: TextStyle(color: Colors.black),
                    //keyboardType: TextInputType.number,
                    onChanged: (val){
                      c=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'Body Color',
                        hintText: " ${c==null?" ":c}",
                        labelStyle: TextStyle(color: Colors.black),
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
                    border: Border.all(width: 2,color: Colors.pink)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      shareableno=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'Shareable Number',
                        //hintText: "Example 54",
                        labelStyle: TextStyle(color: Colors.black),
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
                    border: Border.all(width: 2,color: Colors.pink)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(style: TextStyle(color: Colors.black),
                    maxLength: 500,
                    //keyboardType: TextInputType.number,
                    onChanged: (val){
                      about=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'About',
                        hintText: " ${about==null?" ":about}",
                        labelStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none
                    ) ,
                  ),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width/2-15,right: MediaQuery.of(context).size.width/2-15,top: 5,bottom: 5),
              child: Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: visible,
                  child: Container(
                      //margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: CircularProgressIndicator()
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40,left: MediaQuery.of(context).size.width*0.3,right: MediaQuery.of(context).size.width*0.3,bottom: 40),
              child: RaisedButton(
                color: Colors.pink,
                onPressed: (){
                  submit();
                },
                child: Container(height: 48,
                  child: Center(
                    child: Text("Submit",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
            )
          ],
        ),
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

  // Get State information by API
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
  uploadImage(filename, url) async {
    SharedPreferences pref= await SharedPreferences.getInstance();
    String token= pref.getString("api_token");
    var request = http.MultipartRequest('POST', Uri.parse(url),);
    //("req");
    //(request);
    request.files.add(await http.MultipartFile.fromPath("", filename,),);

    final Map <String ,String> header= {

      'Accept': 'application/json',
      'authorization' : 'Bearer '+'$token',

    };
    request.headers.addAll(header);
    var res = await request.send();
    var response= await http.Response.fromStream(res);
    //('//ing...');
    //(json.decode(response.body));
    var img=await json.decode(response.body)["imgurl"];
    //(img);
    //(response.body);

    //(res.statusCode);
    //(res);
    return img;
  }
  submit()async{
    if(_mycity==null){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select city"));
    }
    else if(_mydist==null){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select District"));
    }
    else if(_myState==null){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select State"));
    }
    else if(_pin==null){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select Pincode"));
    }
    else if(username==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter User Name"));
    }
    else if(shareableno==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter Shareable Number"));
    }
    else if(about==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter About"));
    }
    else if(_image==null){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select Profile Image"));
    }
    else if(h==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter height"));
    }
    else if(w==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter weight"));
    }
    else if(c==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter body color"));
    }
    else if(gender==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select District"));
    }
    else {
      setState(() {
        visible=true;
      });
      String res = await uploadImage(path, url);
      //(h.toString()+" "+w);
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("api_token");
      String firstname = pref.getString("firstname");
      String lastname = pref.getString("lastname");
      String id = pref.getString("id");
      String email = pref.getString("email");
      final Map <String, String> header = {

        'Accept': 'application/json',
        'authorization': 'Bearer ' + '$token',

      };
      final body = {
        "gender":gender,
        "user_id":id,
        "firstname": firstname,
        "lastname": lastname,
        "age": age,
        "city_id": _mycity,
        "dist_id": _mydist,
        "state_id": _myState,
        "pin_id": _pin.toString(),
        "address": address,
        "shareableno": shareableno,
        "image": res,
        "isavailable":_switchValue.toString(),
        "work_status":"1",
        "interested": interested,
        "height":h.toString(),
        "weight":w.toString(),
        "color":c,
        "about":about,
        "username":username

      };
      print(body.toString());

      final response = await http.post(
          "https://www.call2sex.com/api/WorkerApi/SaveInfo", body: body,
          headers: header);
      //(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          visible=false;
        });
        final resData = await json.decode(response.body);
        print(resData);
        if (resData["status"] == "success") {
          _scaffolkey.currentState.showSnackBar(
              APIClient.successToast(resData["msg"]));
        }
        else {
          _scaffolkey.currentState.showSnackBar(
              APIClient.errorToast(resData["msg"]));
        }
      } else {
        setState(() {
          visible=false;
        });
        throw Exception('Failed to submit');
      }
    }
  }
  String fetchusername="";
  String fetchage="",fetchGender="";

  fetchInfo()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    final res= await APIClient().fetchWorkerInfo(id);
    if(res["status"]=="success"){
     // print(result);
      if(mounted){
        setState(() {

          age=res["data"][0]["age"].toString();
          //interset=res["data"][0]["interested"];
          about=res["data"][0]["about"];
          //gender=res["data"][0]["gender"];
          h=res["data"][0]["height"].toString();
          w=res["data"][0]["weight"].toString();
          c=res["data"][0]["color"];
          //isActive=res["data"][0]["isavailable"].toString();

        });
      }
    }
  }
}
