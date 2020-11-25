import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'APIClient.dart';

class GuestBookingConfirmation extends StatefulWidget {
  @override
  _GuestBookingConfirmationState createState() => _GuestBookingConfirmationState();
}

class _GuestBookingConfirmationState extends State<GuestBookingConfirmation> {
  bool check=false;
  confirm()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    String id=pref.getString("id");
    final result= await APIClient().bookingConfirmation(id, "https://www.call2sex.com/api/GuestApi/FetchGuestConfirmedBooking");
    if(result["status"]=="success"){
      setState(() {
        check=true;
        print(check);
      });
    }
    return result["data"];
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        fetchConfirmGuest()
      ],
    );
  }
  fetchConfirmGuest(){
    return FutureBuilder(
      future: confirm(),
      builder: (context,snap){
        if(check==false){
          return Center(
            child: Container(
              height: 70,
              alignment: Alignment.center,
              child: Text("No data found",style: TextStyle(color: Colors.pink,fontSize: 17),),
            ),
          );
        }
        if(snap.data==null){
          return Center(
            child: Container(
                height: 70,
                alignment: Alignment.center,
                child: CircularProgressIndicator()
            ),
          );
        }
        return ListView.builder(
          itemCount: snap.data.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Booking Confirmed by ${snap.data[index]["firstname"]}",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text("Price : ${snap.data[index]["price"]}"),
                        SizedBox(height: 5,),
                        Text("OTP : ${snap.data[index]["otp"]}",style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),),
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
