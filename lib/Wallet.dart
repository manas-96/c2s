import 'package:call2sex/PrimaryWallet.dart';
import 'package:call2sex/SecondaryWallet.dart';
import 'package:flutter/material.dart';

class Wallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blueGrey[900],
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Primary wallet',),
                Tab(text: 'Secondary wallet',),
              ],
            ),
            title: Text('Call2Sex',style: TextStyle(fontSize: 24,color: Colors.white),),

          ),
          body: TabBarView(
            children: [
              PrimaryWallet(),
              SecondaryWallet(),

            ],
          ),
        ),
      ),
    );

  }
}

