import 'package:call2sex/APIClient.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceSetting extends StatefulWidget {
  @override
  _ServiceSettingState createState() => _ServiceSettingState();
}

class _ServiceSettingState extends State<ServiceSetting> {
  String hour="";
  String shots="";
  String night="";
  String trip="";
  String fetchHour="";
  String fetchNight="";
  String fetchTrip="";
  String fetchShots="";
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffolkey,
      appBar: AppBar(
        title: Text("Rate Setting"),
        backgroundColor: Colors.pink[900],
      ),
      body: Container(color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text("Upload your service rate",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2,color: Colors.pink[900])
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      shots=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'Service Rate/Shot',
                        hintText: fetchShots,
                        labelStyle: TextStyle(color: Colors.pink[900]),
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
                    border: Border.all(width: 2,color: Colors.pink[900])
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      hour=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'Service Rate/Hour',
                        hintText: fetchHour,
                        labelStyle: TextStyle(color: Colors.pink[900]),
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
                    border: Border.all(width: 2,color: Colors.pink[900])
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      night=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'Service Rate/Night',
                        hintText: fetchNight,
                        labelStyle: TextStyle(color: Colors.pink[900]),
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
                    border: Border.all(width: 2,color: Colors.pink[900])
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      trip=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'Service Rate/Trip',
                        hintText: fetchTrip,
                        labelStyle: TextStyle(color: Colors.pink[900]),
                        border: InputBorder.none
                    ) ,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: RaisedButton(
                color: Colors.pink[900],
                onPressed: (){
                  rateSetting();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 16),),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
  rateSetting()async{
   if(hour==""){
     setState(() {
       hour="0";
     });
   }
   else if(night==""){
     setState(() {
       night="0";
     });
   }
   else if(shots==""){
     setState(() {
       shots="0";
     });
   }
   else if(trip==""){
     setState(() {
       trip="0";
     });
   }
   else{
     final result=await APIClient().updateRate(hour, night, trip, shots);
     if(result["status"]=="success"){
       _scaffolkey.currentState.showSnackBar(APIClient.successToast(result["msg"]));
       //  Navigator.pop(context);
     }
     else{

       _scaffolkey.currentState.showSnackBar(APIClient.errorToast(result["msg"]));
     }
   }

  }
  bool checkRate=false;
  fetchRate()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    //(id);
    final result= await APIClient().fetchRate(id);
    if(result["status"]=="success"){
      setState(() {
        checkRate=true;
        fetchHour=result["data"][0]["hour"].toString();
        fetchNight= result["data"][0]["night"].toString();
        fetchShots= result["data"][0]["shots"].toString();
        fetchTrip= result["data"][0]["trip"].toString();
      });
    }
  }
}


