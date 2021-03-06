import 'package:call2sex/Dashboard.dart';
import 'package:call2sex/GuestBookingHistory.dart';
import 'package:call2sex/payment.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'APIClient.dart';

class CheckOut extends StatefulWidget {
  final userId;

  const CheckOut({Key key, this.userId}) : super(key: key);
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  String fetchHour="";
  String fetchNight="";
  String fetchTrip="";
  String fetchShots="";
  bool perHour=false;
  bool perShot=false;
  bool perNight=false;
  bool perTrip=false;
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  String amount="0";
  @override
  void initState() {
    // TODO: implement initState
    fetchRate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffolkey,
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        title: Text("Select Service"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing:15,childAspectRatio: 8/6),
                children: [
                  InkWell(
                    child: box(900, "Per Hour",fetchHour,perHour),
                    onTap: (){
                     setState(() {
                       perHour=true;
                        perShot=false;
                        perNight=false;
                        perTrip=false;
                       serviceName="hour";
                       amount=fetchHour;
                     });
                    },
                  ),
                  InkWell(
                    child: box(800, "Per Night",fetchNight,perNight),
                    onTap: (){
                      setState(() {
                        perHour=false;
                         perShot=false;
                         perNight=true;
                        perTrip=false;
                        serviceName="night";
                        amount=fetchNight;
                      });
                    },
                  ),
                  InkWell(
                    child: box(700, "Per Shots",fetchShots,perShot),
                    onTap: (){
                      setState(() {
                        perHour=false;
                        perShot=true;
                        perNight=false;
                        perTrip=false;
                        serviceName="shots";
                        amount=fetchShots;
                      });
                    },
                  ),
                  InkWell(
                    child: box(500, "Trip",fetchTrip,perTrip),
                    onTap: (){
                      setState(() {
                        perHour=false;
                        perShot=false;
                        perNight=false;
                        perTrip=true;
                        serviceName="Trip";
                        amount=fetchTrip;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              //height: 100,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: 60,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(amount,style: TextStyle(color: Colors.pink,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: 60,
                    child: RaisedButton(
                      child: Text("Book Now",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                      color: Colors.pink[900],
                      onPressed: (){
                        bookModel();

                        //
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  box(int num, String name,String amount, bool check){
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.pink[num].withOpacity(0.9)
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(name,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text(amount,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w300),),
            SizedBox(height: 5,),
            check?Icon(Icons.check,color: Colors.white,):Container()
          ],
        )
    );
  }
  String serviceName="";
  fetchRate()async{
    final result= await APIClient().fetchRate(widget.userId);
    if(result["status"]=="success"){
      setState(() {
        fetchHour=result["data"][0]["hour"].toString();
        fetchNight= result["data"][0]["night"].toString();
        fetchShots= result["data"][0]["shots"].toString();
        fetchTrip= result["data"][0]["trip"].toString();
      });
    }
  }
  bookModel()async{
   if(amount=="0"){
     _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Select available service"));
   }
   else{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     String userId=preferences.getString("id");
     final result= await APIClient().bookModel(widget.userId, userId, serviceName, amount);
     if(result["status"]=="success"){
       _scaffolkey.currentState.showSnackBar(APIClient.successToast(result["msg"]));
       Future.delayed(const Duration(seconds: 1), () {
         Navigator.push(context, MaterialPageRoute(builder: (context)=>GuestBookingHistory()));
       });
     }
     else{
       _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Insufficient balance"));
     }
   }
  }
}
