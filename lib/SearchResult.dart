import 'package:flutter/material.dart';

import 'APIClient.dart';
import 'ModelDetails.dart';

class SearchResult extends StatefulWidget {
  final state;
  final dist;
  final city;
  final pin;

  const SearchResult({Key key, this.state, this.dist, this.city, this.pin}) : super(key: key);
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Models"),
        backgroundColor: Colors.pink[900],
      ),
      body: ListView(
        children: [
          fetchModels(),
        ],
      ),
    );
  }
  fetchModels(){
    return FutureBuilder(
      future: getModel(),
      builder: (context,snap){
        if(checkModel){
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            alignment: Alignment.center,
            child: Text("No data to Display",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.w500,fontSize: 18),),
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
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snap.data.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    // //(snap.data);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ModelDetails(
                      id: snap.data[index]["user_id"].toString(),
                      img: "${snap.data[index]["image"]}",
                    )));
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.pink.withOpacity(0.3),
                      image: DecorationImage(
                          image: getImage(snap.data[index]["gender"], snap.data[index]["image"]), fit: BoxFit.fill
                      ),

                    ),

                    child: Container(
                      //color: Colors.pink.withOpacity(0.4),
                        child: Stack(

                          children: [
                            Positioned(left: 5,bottom: 5,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Text(snap.data[index]["username"]==null?"":snap.data[index]["username"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),

                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.favorite,color: Colors.pink,),
                                        SizedBox(width: 4,),
                                        Text(snap.data[index]["counts"].toString(),style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 17),),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                );
              }
          ),
        );
      },
    );
  }
  getImage(String gender, String img){
    //(img);
    //(gender);
    if(img!=null){
      return NetworkImage("https://www.call2sex.com$img");
    }
    else {
      if(gender=="male"||gender=="Male"){
        return AssetImage("images/male.png",);
      }
      else if(gender=="female"||gender=="Female"){
        return AssetImage("images/female.png",);
      }
      else{
        return AssetImage("images/no.png");
      }
    }
  }
  bool checkModel=false;
  getModel()async{
    final result= await APIClient().workerList(widget.city, widget.state, widget.dist, widget.pin);
    if(result["status"]=="success"){
      return result["data"];
    }
    else{
      setState(() {
        checkModel=true;
      });
    }
  }
}
