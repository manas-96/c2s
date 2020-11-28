import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'APIClient.dart';
class CompleteWorkerBooking extends StatefulWidget {
  @override
  _CompleteWorkerBookingState createState() => _CompleteWorkerBookingState();
}

class _CompleteWorkerBookingState extends State<CompleteWorkerBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          fetchCompleteBookings()
        ],
      ),
    );
  }
  bool check=true;
  complete()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    String id=pref.getString("id");
    final result= await APIClient().completeBooking(id, "https://www.call2sex.com/api/WorkerApi/FetchWorkerCompletedBooking");
    if(result["status"]=="success"){
      setState(() {
        check=false;
        print(check);
      });
    }
    return result["data"];
  }
  fetchCompleteBookings(){
    return FutureBuilder(
      future: complete(),
      builder: (context,snap){
        if(check){
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 160,
            alignment: Alignment.center,
            child: Text("Data not found",style: TextStyle(color: Colors.pink,fontSize: 17),),
          );
        }
        if(snap.data==null){
          return Center(
            child: Container(height: 50,width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        //snap.data!=null?//("data")://("no data");
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snap.data.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Booking done by ${snap.data[index]["firstname"]}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 19),),
                        Text("Service type : ${snap.data[index]["service_name"]}",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 18)),
                        Text("Date : : ${snap.data[index]["ondate"]} ",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 18),),
                        Text("Price : ${snap.data[index]["price"]}",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.green,fontSize: 17)),
                        Text("Status : ${snap.data[index]["status"]}",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 17)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
