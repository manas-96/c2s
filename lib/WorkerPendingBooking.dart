import 'package:call2sex/APIClient.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerPendingBooking extends StatefulWidget {
  @override
  _WorkerPendingBookingState createState() => _WorkerPendingBookingState();
}

class _WorkerPendingBookingState extends State<WorkerPendingBooking> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
       fetchBookings(),
      ],
    );
  }

  fetchBookings(){
    return FutureBuilder(
      future: getPendingReq(),
      builder: (context,snap){
        if(check){
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 160,
            alignment: Alignment.center,
            child: Text("Transaction not found",style: TextStyle(color: Colors.pink,fontSize: 17),),
          );
        }
        if(snap.data==null){
          return Center(
            child: Container(height: 50,width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        snap.data!=null?print("data"):print("no data");
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
                        Text("Booking done by ${snap.data[index]["firstname"]} ${snap.data[index]["lastname"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        Text("Service type : ${snap.data[index]["service_name"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                        Text("Price : ${snap.data[index]["price"]}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 17)),
                        Row(
                          children: [
                            RaisedButton(
                              onPressed: (){},
                              color: Colors.green,
                              child: Text("Accept",style: TextStyle(color: Colors.white),),
                            ),
                            SizedBox(width: 20,),
                            RaisedButton(
                              onPressed: (){},
                              color: Colors.red,
                              child: Text("Reject",style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        )
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
  bool check=false;
  getPendingReq()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    final result= await APIClient().pendingBooking(id);
    if(result["status"]!="success"){
      setState(() {
        check=true;
      });

    }
    print(result["data"]);
    return result["data"];
  }
}
