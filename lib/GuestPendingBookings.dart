import 'package:call2sex/APIClient.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuestPendingBooking extends StatefulWidget {
  @override
  _GuestPendingBookingState createState() => _GuestPendingBookingState();
}

class _GuestPendingBookingState extends State<GuestPendingBooking> {
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffolkey,
      body: ListView(
        children: [
          fetchBookings(),
        ],
      ),
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
                        Text("Booking done for ${snap.data[index]["firstname"]} ${snap.data[index]["lastname"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        Text("Service type : ${snap.data[index]["service_name"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                        Text("Price : ${snap.data[index]["price"]}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 17)),
                        Row(
                          children: [
                            Text("Status : "),
                            Text(snap.data[index]["status"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
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
    final result= await APIClient().pendingBookingGuest(id);
    if(result["status"]!="success"){
      setState(() {
        check=true;
      });

    }
    //(result["data"]);
    return result["data"];
  }
  acceptBooking(String bookingId)async{
    final res=await APIClient().acceptBooking(bookingId);
    if(res["status"]=="success"){
      _scaffolkey.currentState.showSnackBar(APIClient.successToast("Booking accepted"));
      (context as Element).reassemble();
    }
    else{
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast(res["msg"]));
    }
  }
  rejectBooking(String bookingId)async{
    final res=await APIClient().bookingCancel(bookingId);
    if(res["status"]=="success"){
      _scaffolkey.currentState.showSnackBar(APIClient.successToast("Booking canceled"));
      (context as Element).reassemble();
    }
    else{
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast(res["msg"]));
    }
  }
}
