import 'dart:ui';

import 'package:call2sex/CheckOut.dart';
import 'package:flutter/material.dart';

import 'APIClient.dart';
import 'ZoomImage.dart';

class ModelDetails extends StatefulWidget {
  final id;

  const ModelDetails({Key key, this.id}) : super(key: key);
  @override
  _ModelDetailsState createState() => _ModelDetailsState();
}

class _ModelDetailsState extends State<ModelDetails> with SingleTickerProviderStateMixin{
  TabController _controller;

  bool checkStatus=false;
  @override
  void initState() {
    fetchDetails();
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    print(widget.id);
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
                                  image: NetworkImage("https://image.shutterstock.com/image-photo/high-fashion-model-womans-face-260nw-1652167117.jpg"),fit: BoxFit.fill
                              )
                          ),
                        ),
                        SizedBox(width: 5,),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(//width: MediaQuery.of(context).size.width*0.38,
                              child: Text(name.substring(0,15),
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                              overflow: TextOverflow.fade,),

                            ),
                            Text(c2sId,style: TextStyle(fontSize: 13.8),)
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
                    image: NetworkImage("https://image.shutterstock.com/image-photo/high-fashion-model-womans-face-260nw-1652167117.jpg"),fit: BoxFit.fill
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
                               onPressed: (){},
                             )
                           ],
                         ),
                         Row(
                           children: [
                             Text("Available",style: TextStyle(color: Colors.black,fontSize: 15),),
                             SizedBox(width: 5,),
                             CircleAvatar(
                               radius: 7,
                               backgroundColor: Colors.green,
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
        if(snap.data==null){
          return Container(
            height: 50,width: 50,
            child: CircularProgressIndicator(),
          );
        }
        return GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            //reverse: true,
            itemCount: snap.data.length,
            itemBuilder: (context,index){
              // print(snap.data[index]["imgurl"]);
              return InkWell(
                onTap: (){
                  print("tapped");
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
        if(snap.data==null){
          return Container(
            height: 50,width: 50,
            child: CircularProgressIndicator(),
          );
        }
        return GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            //reverse: true,
            itemCount: snap.data.length,
            itemBuilder: (context,index){
              // print(snap.data[index]["imgurl"]);
              return InkWell(
                onTap: (){
                  print("tapped");
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
                  child: BackdropFilter(
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
  getFree()async{
    final result= await APIClient().fetchFreeGallery(widget.id.toString());
    print(result);
    if(result["status"]=="success"){
      return result["data"];
    }
  }
  getPrime()async{
    final result= await APIClient().fetchPrimeGallery(widget.id.toString());
    print(result);
    if(result["status"]=="success"){
      return result["data"];
    }
  }
  about(){
    return Padding(
      padding: const EdgeInsets.only(left:2.0,right: 2),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.pink[100].withOpacity(0.5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About Sexy Sila",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                  SizedBox(height: 8,),
                  Text("For merchants who have built their app on Flutter platform - Paytm provides a "
                      "bridge for you to conveniently integrate All-in-One SDK. In this document, we will "
                      "highlight the steps required to integrate All-in-One SDK with Flutter platform for your app."
                      " This platform helps you to build a seamless and responsive checkout experience for your application.",
                    textAlign: TextAlign.justify,
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
                      Text("Gender:"),
                      Text("Female")
                    ],
                  )

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
  fetchDetails()async{
    final res=await APIClient().modelDetails(widget.id);
    if(res["status"]=="success"){
      setState(() {
        name="${res["data"][0]["firstname"]} ${res["data"][0]["lastname"]}";
        c2sId=res["data"][0]["UID"];
      });
    }
  }
}
