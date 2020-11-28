import 'package:call2sex/APIClient.dart';
import 'package:call2sex/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KYC extends StatefulWidget {
  @override
  _KYCState createState() => _KYCState();
}

class _KYCState extends State<KYC> {
  String account="";
  String ifsc="";
  String name="";
  String bank="";
  String fetchaccount="";
  String fetchifsc="";
  String fetchname="";
  String fetchbank="";
  @override
  void initState() {
    fetchBank();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffolkey,
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        title: Text("Payment setting"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color: Colors.pink[900])
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextFormField(
                        // keyboardType: TextInputType.number,
                        onChanged: (val){
                          name=val;
                        },
                        decoration:InputDecoration(
                          //icon: Icon(Icons.person,color: Colors.white,),
                            labelText: 'Account holder ',
                            hintText: fetchname,
                            labelStyle: TextStyle(color: Colors.pink[900]),
                            border: InputBorder.none
                        ) ,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color: Colors.pink[900])
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextFormField(
                        //keyboardType: TextInputType.number,
                        onChanged: (val){
                          bank=val;
                        },
                        decoration:InputDecoration(
                          //icon: Icon(Icons.person,color: Colors.white,),
                            labelText: 'Bank name',
                            hintText: fetchbank,
                            labelStyle: TextStyle(color: Colors.pink[900]),
                            border: InputBorder.none
                        ) ,
                      ),
                    ),
                  ),
                ),
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
                          account=val;
                        },
                        decoration:InputDecoration(
                          //icon: Icon(Icons.person,color: Colors.white,),
                            labelText: 'Account number',
                            hintText: fetchaccount,
                            labelStyle: TextStyle(color: Colors.pink[900]),
                            border: InputBorder.none
                        ) ,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2,color: Colors.pink[900])
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextFormField(
                       // keyboardType: TextInputType.number,
                        onChanged: (val){
                          ifsc=val;
                        },
                        decoration:InputDecoration(
                          //icon: Icon(Icons.person,color: Colors.white,),
                            labelText: 'IFSC',
                            hintText: fetchifsc,
                            labelStyle: TextStyle(color: Colors.pink[900]),
                            border: InputBorder.none
                        ) ,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                RaisedButton(
                  onPressed: (){
                    if(name==""){
                      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter account holder's name"));
                    }
                    else if(account==""){
                      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter account number"));
                    }
                    else if(ifsc==""){
                      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter IFSC code"));
                    }
                    else if(bank==""){
                      _scaffolkey.currentState.showSnackBar(APIClient.errorToast("Enter bank name"));
                    }
                    else{
                      saveBank();
                    }
                  },
                  color: Colors.pink[900],
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 17),),
                  ),
                ),
                check?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name : $fetchname",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
                            Text("A/C  : $fetchaccount",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
                            Text("Bank : $fetchbank",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
                            Text("IFSC : $fetchifsc",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ):Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  bool check=false;
  fetchBank()async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    String id= sharedPreferences.getString("id");
    final result= await APIClient().fetchBank(id);
    if(result["status"]=="success"){
      if(mounted){
        setState(() {
          check=true;
          fetchaccount= result["data"][0]["account_no"]==null?" ":result["data"][0]["account_no"];
          fetchbank= result["data"][0]["bank_name"]==null?" ":result["data"][0]["bank_name"];
          fetchname=result["data"][0]["accholder_name"]==null?" ":result["data"][0]["accholder_name"];
          fetchifsc=result["data"][0]["ifce_code"]==null?" ":result["data"][0]["ifce_code"];
        });
      }
    }
    else{
      print("Bank details not added");
    }
  }
  saveBank()async{
    final res= await APIClient().saveBankDetails(bank, account, name, ifsc);
    if(res["status"]=="success"){

      _scaffolkey.currentState.showSnackBar(APIClient.successToast(res["msg"]));
     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));

    }
    else{
      _scaffolkey.currentState.showSnackBar(APIClient.errorToast(res["msg"]));

    }
  }
}
