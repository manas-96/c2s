import 'package:call2sex/APIClient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'UploadVoter.dart';

class FetchVoter extends StatefulWidget {
  @override
  _FetchVoterState createState() => _FetchVoterState();
}

class _FetchVoterState extends State<FetchVoter> {
    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        title: Text("KYC"),
        actions: [
          show?Container(): RaisedButton(elevation: 0,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadVoter(
                  kyc_id: kyc_voter==""?"0":kyc_voter,
                  kyc_adhar: kyc_adhaar==""?"0":kyc_adhaar,
                  kyc_pan: kyc_pan==""?"0":kyc_pan,
                  kyc_img: kyc_img==""?"0":kyc_img,
                )));
              },
              color: Colors.pink[900],
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(check?"Upload KYC":"Update KYC",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children:[
            showDocs(),
            // voterBack==""?Container():Padding(
            //       padding: const EdgeInsets.only(left:30.0,right: 30,top: 10),
            //       child: Container(
            //         height: 190,
            //
            //         decoration: BoxDecoration(
            //             border: Border.all(color: Colors.pink,width: 2),
            //           image: DecorationImage(
            //             image: NetworkImage("$voterBack"),fit: BoxFit.cover
            //           )
            //         ),
            //       ),
            //     ),
            //     adhaarBack==""?Container():Padding(
            //       padding: const EdgeInsets.only(left:30.0,right: 30,top: 10),
            //       child: Container(
            //         height: 190,
            //
            //         decoration: BoxDecoration(
            //           border: Border.all(color: Colors.pink,width: 2),
            //           image: DecorationImage(
            //             image: NetworkImage("$adhaarBack"),fit: BoxFit.cover
            //           )
            //         ),
            //       ),
            //     ),
            //
            // SizedBox(height:20),
            
          ]
        ),
      ),
    );
  }
  bool check=false;
  String kyc_voter="";
  String kyc_adhaar="";
  String kyc_pan="";
  String kyc_img="";
  String voterBack="";
  String adhaarBack="";
  String approve=" ";
  bool show=false;
  fetchDocs()async{
    final result= await APIClient().fetchVoter();
    if(result["status"]=="success"){
      //print(result);
      for(int i=0;i<1;i++){
        if(mounted){
          setState(() {
            show=result["data"][0]["status"];
            if(result["data"][i]["cat_id"]==2){
              voterBack="https://www.call2sex.com/${result["data"][i]["back_imgurl"]}";
              kyc_voter=result["data"][i]["kyc_id"].toString();
            }
            else if(result["data"][i]["cat_id"]==1){
              adhaarBack="https://www.call2sex.com/${result["data"][i]["back_imgurl"]}";
              kyc_adhaar=result["data"][i]["kyc_id"].toString();
            }
            else if(result["data"][i]["cat_id"]==3){
              kyc_pan=result["data"][i]["kyc_id"].toString();
            }
            else{
              kyc_img=result["data"][i]["kyc_id"].toString();
            }
          });
        }
      }
      return result["data"];
    }
    else{
      if(mounted){
        setState(() {
          check=true;
        });
      }
    }
  }
  showDocs(){
    return FutureBuilder(
      future: fetchDocs(),
      builder: (context,snap){
        if(check){
          return Center(
            child: Text("Kyc not uploaded.\n Please upload.",style: TextStyle(color: Colors.pink,fontSize: 17),),
          );
        }
        if(snap.data==null){
          return Center(
            child: Container(
              height: 50,width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        return ListView.builder(
         // gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5,childAspectRatio: 12/8),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snap.data.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(left:30.0,right: 30,top: 10),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(snap.data[index]["status"]?"Approved":"Pending",style: TextStyle(color:snap.data[index]["status"]==true?Colors.green:Colors.red,fontSize: 18,fontWeight: FontWeight.w500 ),),
                    ),
                    height: 190,
                   
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.pink,width: 2),
                      image: DecorationImage(
                        image: NetworkImage("https://www.call2sex.com${snap.data[index]["back_imgurl"]!=null||snap.data[index]["back_imgurl"]!=""?snap.data[index]["back_imgurl"]:snap.data[index]["front_imgurl"]}"),fit: BoxFit.cover
                      )
                    ),
                  ),
                );
              },
        );
      },
    );
  }
}