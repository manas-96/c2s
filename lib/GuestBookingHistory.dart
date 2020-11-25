
import 'package:call2sex/GuestBookingComplete.dart';
import 'package:call2sex/GuestBookingConfirmation.dart';
import 'package:call2sex/GuestPendingBookings.dart';
import 'package:flutter/material.dart';

class GuestBookingHistory extends StatelessWidget {
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
                Tab(text: 'Complete',),
              ],
            ),
            title: Text('Booking History',style: TextStyle(fontSize: 24,color: Colors.white),),

          ),
          body: TabBarView(
            children: [
              GuestPendingBooking(),
              GuestBookingConfirmation(),
              GuestBookingComplete()

            ],
          ),
        ),
      ),
    );
  }
}

