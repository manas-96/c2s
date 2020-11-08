import 'package:call2sex/APIClient.dart';
import 'package:call2sex/ModelDetails.dart';
import 'package:flutter/material.dart';

class Worker extends StatefulWidget {
  @override
  _WorkerState createState() => _WorkerState();
}

class _WorkerState extends State<Worker> {
  bool checkModel=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Call2Sex"),
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //color: Colors.pink[900],
        child: ListView(
          children: [
            fetchModels()
          ],
        )
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
        return GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snap.data.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                 // print(snap.data);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ModelDetails(
                    id: snap.data[index]["user_id"].toString(),
                  )));
                },
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(snap.data[index]["image"]==null?"https://im.indiatimes.in/content/itimes/photo/2015/Jan/8/1420735448-indian-actress-sana-khan-navel-show-hot-photo-gallery-pics-pictures.jpg?w=875&h=1317&cc=1"
                          :"https://www.call2sex.com/${snap.data[index]["image"].toString().replaceFirst('~', '')}"
                          ),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Container(
                      //color: Colors.pink.withOpacity(0.4),
                      child: Stack(

                        children: [
                          Positioned(left: 5,bottom: 5,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Text("Model Model",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
                                Row(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.favorite,color: Colors.pink,),
                                    Text("132",style: TextStyle(color: Colors.white),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
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
    final result= await APIClient().workerList();
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
