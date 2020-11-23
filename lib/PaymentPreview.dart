import 'package:call2sex/APIClient.dart';
import 'package:call2sex/payment.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentPreview extends StatefulWidget {
  @override
  _PaymentPreviewState createState() => _PaymentPreviewState();
}

class _PaymentPreviewState extends State<PaymentPreview> {
  String user_id="";
  SharedPreferences sharedPreferences;
  String amount="";
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      user_id= sharedPreferences.getString("id");

      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffolkey,
      appBar: AppBar(
        title: Text("Add Money"),
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2,color: Colors.pink[900])
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(style: TextStyle(color: Colors.black),
                     keyboardType: TextInputType.number,
                    onChanged: (val){
                      amount=val;
                    },
                    decoration:InputDecoration(
                       // icon: Icon(Icons.pay,color: Colors.white,),
                        labelText: 'Amount',
                        labelStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none
                    ) ,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            RaisedButton(
              onPressed: (){
                if(amount==""){
                  _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Please enter minimum 100 Rs amount"));
                }
                else if(double.parse(amount).toInt()<100){
                  _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Please enter minimum 100 Rs amount"));
                }
                else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment(
                    amount: amount,
                    id: user_id,
                  )));
                }
              },
              color: Colors.pink[900],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Pay",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
