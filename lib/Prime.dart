import 'package:call2sex/APIClient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_mac/get_mac.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prime extends StatefulWidget {
  @override
  _PrimeState createState() => _PrimeState();
}

class _PrimeState extends State<Prime> {
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  var id=1;
  String pack="Damaka pack";
  String duration="6";
  String amount="199";
  DateTime dateTime;
  @override
  void initState() {
    // TODO: implement initState
    fetchPrime();
    super.initState();
    dateTime= DateTime.now();
    //(dateTime.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffolkey,
      appBar: AppBar(
        title: Text("Prime"),
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top:8.0,bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: Text("Benefits :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.pink[900]),),

                              ),
                            //  Text('MAC Address : $_platformVersion\n'),
                              SizedBox(height: 15,),
                              Text("1. Premium Member Discounts",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),
                              SizedBox(height: 5,),
                              Text("2. Read verified user paid gallery",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),
                              SizedBox(height: 5,),
                              Text("3. See photo and age verification",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),
                              SizedBox(height: 5,),
                              Text("4. Give like to models",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),
                              SizedBox(height: 5,),
                              Text("5. ZERO cancellation fees",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),
                              SizedBox(height: 5,),
                              Text("6. Premium support",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),
                              SizedBox(height: 5,),
                              Text("7. Private chat (coming soon)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),

                              SizedBox(height: 15,),
                            ],
                          )
                        ),
                      ),
                    ),
                  ),
                   Row(
                     children: [
                       Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(width: MediaQuery.of(context).size.width/2-20,
                             child: Card(
                               child: RadioListTile(
                                 value: 0,
                                 groupValue: id,
                                 title: Text("RS 99",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink[900]),),
                                 subtitle: Text("1 month Normal pack"),
                                 onChanged: (val) {
                                   setState(() {
                                     pack= "Normal pack";
                                     duration="1";
                                     amount="99";
                                     id=val;
                                     //(id.toString());
                                   });
                                 },

                                 activeColor: Colors.pink[900],
                               ),
                             ),
                           )
                       ),
                       Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(width: MediaQuery.of(context).size.width/2-20,
                             child: Card(
                               child: RadioListTile(
                                 value: 1,
                                 groupValue: id,
                                 title: Text("RS 199 ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink[900]),),
                                 subtitle: Text("6 months Damaka pack"),
                                 onChanged: (val) {
                                   setState(() {
                                     pack="Damaka pack";
                                     duration="6";
                                     amount="199";
                                     id=val;
                                     //(id.toString());
                                   });
                                 },

                                 activeColor: Colors.pink[900],
                               ),
                             ),
                           )
                       ),
                     ],
                   )

                ],
              ),
              Container(height: 50,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: Colors.pink[900],
                  onPressed: (){
                    prime();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Pay",
                      style: TextStyle(color: Colors.white,fontSize: 18),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  prime()async{
    if(checkPrime){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Already prime member"));
    }
    else{
      SharedPreferences preferences=await SharedPreferences.getInstance();
      String id= preferences.getString("id");
      //(id+" "+amount+" "+duration+" "+dateTime.toString().substring(0,16)+pack);
      final res=await APIClient().prime(id, amount, duration, dateTime.toString().substring(0,16), pack);
      if(res["status"]=="success"){
        _scaffolkey.currentState.showSnackBar(APIClient.successToast(res["msg"]));
      }
      else{
        _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Insufficient balance"));
      }
    }
  }
  bool checkPrime=false;
  fetchPrime()async{
    SharedPreferences pref=await  SharedPreferences.getInstance();
    String id= pref.getString("id");
    final req=await APIClient().fetchPrime(id);
    if(req["status"]=="success"){
      if(mounted){
        setState(() {
          checkPrime=true;
        });
      }
      else{
        return;
      }
    }
  }
}
