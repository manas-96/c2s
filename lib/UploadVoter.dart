import 'package:flutter/material.dart';


class UploadVoter extends StatefulWidget {
  @override
  _UploadVoterState createState() => _UploadVoterState();
}

class _UploadVoterState extends State<UploadVoter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload KYC"),
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing:15,childAspectRatio: 8/6),
          children: [
            InkWell(
              child: box(800, "Upload Voter(front)",),
              onTap: (){
                //getImage();
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
              },
            ),
            InkWell(
              child: box(800, "Upload Voter(back)",),
              onTap: (){

                //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
              },
            ),
            InkWell(
              child: box(800, "Upload Selfie",),
              onTap: (){
                //getImage();
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadGallery()));
              },
            ),
          ],
        ),
      ),
    );
  }
  box(int num, String name){
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.pink[num].withOpacity(0.9)
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 1,),
            Text(name,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
          ],
        )
    );
  }
}
