import 'package:call2sex/PrimaryWallet.dart';
import 'package:call2sex/SecondaryWallet.dart';
import 'package:flutter/material.dart';

import 'PaymentPreview.dart';
import 'Withdrawl.dart';

class Wallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Center(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Add Money",style: TextStyle(color: Colors.white),),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPreview()));
                  },

                ),
              ),
            ],
            backgroundColor: Colors.pink[900],
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Primary wallet',),
                Tab(text: 'Reward',),
                Tab(text:'Withdrawal')
              ],
            ),
            title: Text('Call2Sex',style: TextStyle(fontSize: 24,color: Colors.white),),

          ),
          body: TabBarView(
            children: [
              PrimaryWallet(),
              SecondaryWallet(),
              Withdraw()
            ],
          ),
        ),
      ),
    );

  }
}

