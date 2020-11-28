import 'package:call2sex/APIClient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerBookingConfirmation extends StatefulWidget {
  @override
  _WorkerBookingConfirmationState createState() => _WorkerBookingConfirmationState();
}

class _WorkerBookingConfirmationState extends State<WorkerBookingConfirmation> {
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  String otp="";
  bool check=true;
  confirm()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    String id=pref.getString("id");
    final result= await APIClient().bookingConfirmation(id, "https://www.call2sex.com/api/WorkerApi/FetchWorkerConfirmedBooking");
    if(result["status"]!="success"){
      setState(() {
        check=false;
      });
    }
    return result["data"];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    confirm();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffolkey,
      body: ListView(
        children: [
          fetchConfirmWorker()
        ],
      ),
    );
  }

  fetchConfirmWorker(){
    return FutureBuilder(
      future: confirm(),
      builder: (context,snap){
        if(check==false){
          return Center(
            child: Container(
              height: 70,
              alignment: Alignment.center,
              child: Text("No data found",style: TextStyle(color: Colors.pink[900],fontSize: 17),),
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
        print(snap.data);
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
                        Text("Booking Confirmed for ${snap.data[index]["firstname"]}",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text("Price : ${snap.data[index]["price"]}"),
                        SizedBox(height: 5,),
                        Text("Guest ID: ${snap.data[index]["uid"]} ",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                        SizedBox(height: 5,),
                        Text("Service name : ${snap.data[index]["service_name"]}"),
                        SizedBox(height: 5,),
                        Text("Enter OTP to receive payment",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
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
                                  otp=val;
                                },
                                decoration:InputDecoration(
                                  //icon: Icon(Icons.person,color: Colors.white,),
                                    labelText: 'OTP',
                                    labelStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none
                                ) ,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(width: MediaQuery.of(context).size.width,
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                color: Colors.pink[900],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Submit",style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                onPressed: (){
                                  verifyBooking(snap.data[index]["booking_id"].toString());
                                },
                              )
                            ],
                          ),
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
  verifyBooking(String bookingId,)async{
    if(otp==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter otp"));
    }
    else{
      final res=await APIClient().verifyBooking(bookingId,otp);
      if(res["status"]=="success"){
        _scaffolkey.currentState.showSnackBar(APIClient.successToast(res["msg"]));
        (context as Element).reassemble();
      }
      else{
        _scaffolkey.currentState.showSnackBar(APIClient.errorToast(res["msg"]));
      }
    }
  }

}
