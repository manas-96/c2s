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
            Container(
              height: MediaQuery.of(context).size.height/3.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://image.shutterstock.com/image-photo/high-fashion-model-womans-face-260nw-1652167117.jpg"),fit: BoxFit.fill
                )
              ),
            ),
             Padding(
               padding: EdgeInsets.all(12),
               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [
                       Icon(Icons.favorite,color: Colors.red.withOpacity(0.5),),
                       SizedBox(width: 10,),
                       Text("132",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                     ],
                   ),
                   SizedBox(height: 20,),
                   Text("Horney baby",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                   Text("Horney baby",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                   Text("Horney baby",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),],
               ),
             ),


             Container(
               decoration: new BoxDecoration(color: Colors.pink[900]),
               child:  TabBar(
                 controller: _controller,
                  tabs: [
                    Tab(
                      text: 'Free gallery',
                    ),
                    Tab(
                      text: 'paid gallery',
                    ),
                    Tab(
                      text: 'Review',
                    )
                ],
               ),
             ),
            new Container(
              height: MediaQuery.of(context).size.height,
              child: new TabBarView(
                controller: _controller,
                children: <Widget>[
                  fetchFreeGallery(),
                  fetchFreeGallery(),
                  fetchFreeGallery(),

                ],
              ),
            ),
           ]
      )
    );
  }
  fetchFreeGallery(){
    return FutureBuilder(
      future: getModel(),
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
  getModel()async{
    final result= await APIClient().fetchFreeGallery(widget.id.toString());
    print(result);
    if(result["status"]=="success"){
      return result["data"];
    }
  }
}
