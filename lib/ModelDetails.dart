import 'dart:ui';

import 'package:call2sex/CheckOut.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'APIClient.dart';
import 'ZoomImage.dart';

class ModelDetails extends StatefulWidget {
  final id;
  final img;

  const ModelDetails({Key key, this.id, this.img}) : super(key: key);
  @override
  _ModelDetailsState createState() => _ModelDetailsState();
}

class _ModelDetailsState extends State<ModelDetails> with SingleTickerProviderStateMixin{
  TabController _controller;

  bool prime=false;
  fetchPrime()async{
    SharedPreferences pref=await  SharedPreferences.getInstance();
    String id= pref.getString("id");
    final req=await APIClient().fetchPrime(id);
    if(req["status"]=="success"){
      setState(() {
        prime=true;
      });
    }
  }
  bool checkStatus=false;
  @override
  void initState() {
    fetchPrime();
    fetchDetails();
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    //(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Model Details"),
        backgroundColor: Colors.pink[900],
      ),
      body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: MediaQuery.of(context).size.width,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(//crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: getImage(widget.img),fit: BoxFit.fill
                              )
                          ),
                        ),
                        SizedBox(width: 5,),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(//width: MediaQuery.of(context).size.width*0.38,
                              child: Text(name.length>15?name.substring(0,15):name,
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                              overflow: TextOverflow.fade,),

                            ),
                            Text(c2sId,style: TextStyle(fontSize: 13),)
                          ],
                        ),
                        SizedBox(width: 5,),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.verified,color: Colors.green,) ,
                            Text("")
                          ],
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        RaisedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOut(
                              userId: widget.id,
                            )));
                          },
                          color: Colors.pink,
                          child: Text("Book Now",style: TextStyle(color: Colors.white),),
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8),
              child: Container(
                height: MediaQuery.of(context).size.height*0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: getImage(widget.img),fit: BoxFit.fill
                  )
                ),
              ),
            ),
             Padding(
               padding: EdgeInsets.all(12),
               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(width: MediaQuery.of(context).size.width,
                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             Icon(Icons.favorite,color: Colors.pink,size: 30,),
                             SizedBox(width: 5,),
                             Text("132",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                             SizedBox(width: 10,),
                             IconButton(
                               icon: Icon(Icons.share),
                               onPressed: (){
                                 final RenderBox box = context.findRenderObject();
                                 Share.share("https://www.call2sex.com${widget.img}",
                                     //subject: "refer your friend. Referral code $uid ",
                                     sharePositionOrigin:
                                     box.localToGlobal(Offset.zero) &
                                     box.size);
                               },
                             )
                           ],
                         ),
                         Row(
                           children: [
                             Text(isActive=="true"?"Available":"Not available",style: TextStyle(color: Colors.black,fontSize: 15),),
                             SizedBox(width: 5,),
                             CircleAvatar(
                               radius: 7,
                               backgroundColor: isActive=="true"?Colors.green:Colors.red,
                             )
                           ],
                         )
                       ],
                     ),
                   ),
                   SizedBox(height: 10,),

                 ],
               ),
             ),


             Container(
               decoration: new BoxDecoration(color: Colors.pink[900]),
               child:  TabBar(
                 controller: _controller,
                  tabs: [
                    Tab(
                      text: 'About',
                    ),
                    Tab(
                      text: 'Free Gallery',
                    ),
                    Tab(
                      text: 'Paid Gallery',
                    ),

                ],
               ),
             ),
            new Container(
              height: MediaQuery.of(context).size.height,
              child: new TabBarView(
                controller: _controller,
                children: <Widget>[
                  about(),
                  fetchFreeGallery(),
                  fetchPrimeGallery()

                ],
              ),
            ),
           ]
      )
    );
  }
  fetchFreeGallery(){
    return FutureBuilder(
      future: getFree(),
      builder: (context,snap){
        if(checkFree){
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            alignment: Alignment.center,
            child: Text("Photos not found",style: TextStyle(color: Colors.pink,fontSize: 17),),
          );
        }
        if(snap.data==null){
          return Center(
            child: Container(height: 50,width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        return GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            //reverse: true,
            itemCount: snap.data.length,
            itemBuilder: (context,index){
              // //(snap.data[index]["imgurl"]);
              return InkWell(
                onTap: (){
                  //("tapped");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ZoomImage(img: snap.data[index]["imgurl"],)));
                },

                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(snap.data[index]["imgurl"]==null?"https://im.indiatimes.in/content/itimes/photo/2015/Jan/8/1420735448-indian-actress-sana-khan-navel-show-hot-photo-gallery-pics-pictures.jpg?w=875&h=1317&cc=1"
                              :"https://www.call2sex.com//${snap.data[index]["imgurl"].toString().replaceRange(0, 1, "")}"
                          ),
                          fit: BoxFit.fill
                      )
                  ),

                ),

              );
            }
        );
      },
    );
  }
  fetchPrimeGallery(){
    return FutureBuilder(
      future: getPrime(),
      builder: (context,snap){
        if(checkPrime){
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            alignment: Alignment.center,
            child: Text("Photos not found",style: TextStyle(color: Colors.pink,fontSize: 17),),
          );
        }
        if(snap.data==null){
          return Center(
            child: Container(height: 50,width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        return GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5),
            //shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            //reverse: true,
            itemCount: snap.data.length,
            itemBuilder: (context,index){
              // //(snap.data[index]["imgurl"]);
              return InkWell(
                onTap: (){
                  //("tapped");
                 if(prime){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ZoomImage(img: snap.data[index]["imgurl"],)));
                 }
                },

                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(snap.data[index]["imgurl"]==null?"https://im.indiatimes.in/content/itimes/photo/2015/Jan/8/1420735448-indian-actress-sana-khan-navel-show-hot-photo-gallery-pics-pictures.jpg?w=875&h=1317&cc=1"
                              :"https://www.call2sex.com//${snap.data[index]["imgurl"].toString().replaceRange(0, 1, "")}"
                          ),
                          fit: BoxFit.fill
                      )
                  ),
                  child:prime?Text(""): BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                    child: Container(
                      decoration: BoxDecoration(
                          //shape: BoxShape.circle,
                          color: Colors.pink.withOpacity(0.3)
                      ),
                    ),
                  ),

                ),

              );
            }
        );
      },
    );
  }
  bool checkFree=true;
  getFree()async{
    final result= await APIClient().fetchFreeGallery(widget.id.toString());
    //(result);
    if(result["status"]=="success"){
      setState(() {
        checkFree=false;
      });
      return result["data"];
    }
  }
  bool checkPrime=true;
  getPrime()async{
    final result= await APIClient().fetchPrimeGallery(widget.id.toString());
    //(result);
    if(result["status"]=="success"){
      setState(() {
        checkPrime=false;
      });
      return result["data"];
    }
  }
  about(){
    return Padding(
      padding: const EdgeInsets.only(left:2.0,right: 2),
      child: ListView(
        //shrinkWrap: true,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.pink[100].withOpacity(0.5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                //shrinkWrap: true,
                children: [
                  Text(name,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                  SizedBox(height: 8,),
                  Text(aboutModel==null?"Come on let's have some fun":aboutModel,
                    textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 17)
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.pink[100].withOpacity(0.5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("General Information",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text("Gender : ",style: TextStyle(fontSize: 17)),
                      Text(gender==null||gender==""?"Unknown":gender,style: TextStyle(fontSize: 17),)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text("Height : ",style: TextStyle(fontSize: 17)),
                      Text(height==null||height==""?"Unknown":height,style: TextStyle(fontSize: 17),)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text("Weight : ",style: TextStyle(fontSize: 17)),
                      Text(weight==null||weight==""?"Unknown":weight,style: TextStyle(fontSize: 17),)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text("Color : ",style: TextStyle(fontSize: 17)),
                      Text(bodyColor==null||bodyColor==""?"Unknown":bodyColor,style: TextStyle(fontSize: 17),)
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  String name="";
  String image="";
  String c2sId="";
  String aboutModel="";
  String gender="";
  String height="";
  String weight="";
  String bodyColor;
  String isActive;
  fetchDetails()async{
    //(widget.id);
    final res=await APIClient().fetchWorkerInfo(widget.id);
    if(res["status"]=="success"){
      //(res);
      setState(() {
        name="${res["data"][0]["firstname"]==null?" ":res["data"][0]["firstname"]} ${res["data"][0]["lastname"]==null?" ":res["data"][0]["lastname"]}";
        c2sId=res["data"][0]["UID"];
        aboutModel=res["data"][0]["about"];
        gender=res["data"][0]["gender"];
        height=res["data"][0]["height"];
        weight=res["data"][0]["weight"];
        bodyColor=res["data"][0]["color"];
        isActive=res["data"][0]["isactive"].toString();
      });
    }
  }
  getImage( String img){
    //("image//////////////////////");
    //(img);
    if(widget.img=="null" || widget.img==""){
      //("image//////////////////////asset");
      return AssetImage("images/no.png");

    }
    else {
      //("image//////////////////////asset");
      return NetworkImage("https://www.call2sex.com$img");
    }
  }
}
