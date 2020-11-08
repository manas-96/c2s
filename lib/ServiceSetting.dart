import 'package:flutter/material.dart';

class ServiceSetting extends StatefulWidget {
  @override
  _ServiceSettingState createState() => _ServiceSettingState();
}

class _ServiceSettingState extends State<ServiceSetting> {
  String hour="";
  String fullDay="";
  String night="";
  String trip="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Setting"),
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
              child: Text("Upload your service rate",style: TextStyle(fontSize: 17,),),
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
                      hour=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'Service rate/hour',
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
                        labelText: 'Service rate/night',
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
                      fullDay=val;
                    },
                    decoration:InputDecoration(
                      //icon: Icon(Icons.person,color: Colors.white,),
                        labelText: 'Service rate on full day',
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
                        labelText: 'Service rate on trip',
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
                onPressed: (){},
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
}
