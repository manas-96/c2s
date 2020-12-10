import 'package:call2sex/APIClient.dart';
import 'package:call2sex/PaymentPreview.dart';
import 'package:call2sex/Withdrawl.dart';
import 'package:flutter/material.dart';

class PrimaryWallet extends StatefulWidget {
  @override
  _PrimaryWalletState createState() => _PrimaryWalletState();
}

class _PrimaryWalletState extends State<PrimaryWallet> {
  String balance="";
  walletBalance()async{
    final result= await APIClient().primaryBalance();
    print(result);
    if(result["status"]=="failed"){
      setState(() {
        balance="0";
      });
    }
    else{
      setState(() {
        balance= result["data"][0]["Balance"].toString();
        //(balance);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    walletBalance();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      //color: Colors.pink[900],
      child: ListView(
        children: <Widget>[
          Container(color: Colors.pink[900],
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Rs ",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w300,)),
                      Text(balance,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(" Available balance",style: TextStyle(color: Colors.white,fontSize: 12),),
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        // FlatButton(
                        //   child: Text("Withdraw"),
                        //   onPressed: (){
                        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Withdraw()));
                        //   },
                        //   color: Colors.white,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 6,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(" All Transactions :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
          ),
          transaction(),

        ],
      ),
    );
  }

  bool trnasCheck=false;
  getTransaction()async{
    final result= await APIClient().primaryTrancation();
    if(result["status"]=="success"){
      return result["data"];
    }
    else{
      setState(() {
        trnasCheck=true;
      });
    }
  }
  transaction(){
    return FutureBuilder(
      future: getTransaction(),
      builder: (context,snap){
        if(trnasCheck){
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
            return Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
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
                          child:snap.data[index]["amounttype"]=="In"? Icon(Icons.add):Icon(Icons.remove),
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            title(snap.data[index]["string"]==null?"":snap.data[index]["string"]),
                            SizedBox(height: 10,),
                            Text(snap.data[index]["ondate"]+" , " + snap.data[index]["ontime"]),
                            SizedBox(height: 6,),
                            Container(
                              width: MediaQuery.of(context).size.width/2,
                                child: Text("TxnID : ${snap.data[index]["txnid"]==null?"":snap.data[index]["txnid"]}",
                                overflow: TextOverflow.clip,))
                          ],
                        ),
                        Text("Rs ${snap.data[index]["amount_in"]}",style: TextStyle(color:snap.data[index]["amounttype"]=="In" ?Colors.green:Colors.red,fontSize: 18,fontWeight: FontWeight.bold),),
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
  title(String intype){
    ////(intype);
    return Text(intype,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),);
    // if(intype=="booking"){
    //   return Text("Money paid for booking");
    // }
    // else if(intype=="reward"){
    //   Text("Money received from C2S");
    // }
    // else{
    //   Text("Money added to wallet");
    // }
  }
}
