import 'package:call2sex/WorkerBookingHistoryTab.dart';
import 'package:call2sex/WorkerPendingBooking.dart';
import 'package:flutter/material.dart';

class WorkerBookingHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(

            backgroundColor: Colors.pink[900],
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Pending request',),
                Tab(text: 'Booking history',),
              ],
            ),
            title: Text('Call2Sex',style: TextStyle(fontSize: 24,color: Colors.white),),

          ),
          body: TabBarView(
            children: [
              WorkerPendingBooking(),
              WorkerBookingHistoryTab()

            ],
          ),
        ),
      ),
    );
  }
}

