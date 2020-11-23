import 'package:call2sex/APIClient.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Withdraw extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  String walletBalance="";
  String amount="";
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffolkey,
      body: ListView(

        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              color: Colors.pink[900],
             // height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:10.0,right: 10,top: 20,bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                          border: Border.all(width: 0.5,color: Colors.pink[900])
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
                              hintText: 'Min 100 & Max 100000',
                              labelStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none
                          ) ,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  RaisedButton(
                    onPressed: (){
                      withdrawalReq();
                    },
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Submit",style: TextStyle(color: Colors.black,fontSize: 17),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
          transaction()
        ],
      ),
    );
  }
  bool check=false;
  getList()async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    String id= preferences.getString("id");
    final res= await APIClient().fetchWithdraw(id);
    print(res);
    if(res["status"]!="success"){
      setState(() {
        check=true;
      });

    }
    else{
      return res["data"];
    }
  }
  transaction(){
    return FutureBuilder(
      future: getList(),
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
        return ListView.builder(
          itemCount: snap.data.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            String price=snap.data[index]["amount"].toInt().toString();
            return Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white.withOpacity(0.8),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 60,width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.teal[900].withOpacity(0.5)),
                          ),
                          child: Icon(Icons.account_balance),
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Withdrawal request",style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            // Text(snap.data[index]["ondate"]),
                            // SizedBox(height: 6,),
                            Text("Transaction id : ${snap.data[index]["txnid"]}"),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("Status : "),
                                Text("${snap.data[index]["status"]}",style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),

                        Text("Rs ${price}",style: TextStyle(color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold),),

                        SizedBox(width: 1,)
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 70,),
                      Container(
                        height: 1,width: MediaQuery.of(context).size.width-70,
                        color: Colors.grey.withOpacity(0.5),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  withdrawalReq()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    if(amount==""){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Please enter amount"));
    }
    else if(double.parse(amount).toInt()<100||double.parse(amount).toInt()>100000){
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Please enter valid amount"));
    }
    else{
      final res= await APIClient().withdrawalReq(id, amount);
      if(res["status"]=="success"){
        _scaffolkey.currentState.showSnackBar(APIClient.successToast(res["msg"]));
      }
      else{
        _scaffolkey.currentState.showSnackBar(APIClient.errorToast(res["msg"]));
      }
    }

  }

}
