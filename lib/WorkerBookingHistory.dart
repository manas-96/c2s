import 'package:call2sex/WorkerBookingConfirmation.dart';
import 'package:call2sex/CompleteWorkerBooking.dart';
import 'package:call2sex/WorkerPendingBooking.dart';
import 'package:flutter/material.dart';

class WorkerBookingHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(

            backgroundColor: Colors.pink[900],
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Pending',),
                Tab(text: 'Confirmation'),
                Tab(text: 'history',),
              ],
            ),
            title: Text('Booking History',style: TextStyle(fontSize: 24,color: Colors.white),),

          ),
          body: TabBarView(
            children: [
              WorkerPendingBooking(),
              WorkerBookingConfirmation(),
              CompleteWorkerBooking()

            ],
          ),
        ),
      ),
    );
  }
}

