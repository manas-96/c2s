import 'package:flutter/material.dart';

import 'APIClient.dart';


class SecondaryWallet extends StatefulWidget {
  @override
  _SecondaryWalletState createState() => _SecondaryWalletState();
}

class _SecondaryWalletState extends State<SecondaryWallet> {
  @override
  void initState() {
    // TODO: implement initState
    walletBalance();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      //color: Colors.pink[500],
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
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

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
            child: Text(" All Transactions :",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          ),
          transaction(),

        ],
      ),
    );
  }
  String balance="";
  walletBalance()async{
    final result= await APIClient().secondaryBalance();
    print(result);
    if(result["status"]=="failed"){
      setState(() {
        balance="0";
      });
    }
    else{
      setState(() {
        balance= result["data"][0]["Balance"].toString();
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
                          child: Icon(Icons.transit_enterexit),
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Send money to ABC",style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Text("20/10/2020"),
                            SizedBox(height: 6,),
                            Text("Transaction id : ${snap.data[index]["TxnId"]}")
                          ],
                        ),
                        Text("Rs ${snap.data[index]["Amount_In"]}",style: TextStyle(color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold),),
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
  bool trnasCheck=false;

  getTransaction()async{
    final result= await APIClient().secondaryTrancation();
    if(result["status"]=="success"){
      return result["data"];
    }
    else{
      setState(() {
        trnasCheck=true;
      });
    }
  }
}
