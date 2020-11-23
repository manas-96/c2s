import 'package:flutter/material.dart';

class Prime extends StatefulWidget {
  @override
  _PrimeState createState() => _PrimeState();
}

class _PrimeState extends State<Prime> {
  var id=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prime"),
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top:8.0,bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: Text("Benefits :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.pink[900]),),

                              ),
                              SizedBox(height: 15,),
                              Text("1. Premium Member Discounts",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),
                              SizedBox(height: 5,),
                              Text("2. Read verified user paid gallery",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),
                              SizedBox(height: 5,),
                              Text("3. See photo and age verification",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),
                              SizedBox(height: 5,),
                              Text("4. Give like to models",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),
                              SizedBox(height: 5,),
                              Text("5. ZERO cancellation fees",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),
                              SizedBox(height: 5,),
                              Text("6. Premium support",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),
                              SizedBox(height: 5,),
                              Text("7. Private chat (coming soon)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),

                              SizedBox(height: 15,),
                            ],
                          )
                        ),
                      ),
                    ),
                  ),
                   Row(
                     children: [
                       Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(width: MediaQuery.of(context).size.width/2-20,
                             child: Card(
                               child: RadioListTile(
                                 value: 0,
                                 groupValue: id,
                                 title: Text("RS 99",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink[900]),),
                                 subtitle: Text("3 months"),
                                 onChanged: (val) {
                                   setState(() {
                                     id=val;
                                   });
                                 },

                                 activeColor: Colors.pink[900],
                               ),
                             ),
                           )
                       ),
                       Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(width: MediaQuery.of(context).size.width/2-20,
                             child: Card(
                               child: RadioListTile(
                                 value: 1,
                                 groupValue: id,
                                 title: Text("RS 199",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink[900]),),
                                 subtitle: Text("1 year"),
                                 onChanged: (val) {
                                   setState(() {
                                     id=val;
                                   });
                                 },

                                 activeColor: Colors.pink[900],
                               ),
                             ),
                           )
                       ),
                     ],
                   )

                ],
              ),
              Container(height: 50,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: Colors.pink[900],
                  onPressed: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Pay",
                      style: TextStyle(color: Colors.white,fontSize: 18),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
