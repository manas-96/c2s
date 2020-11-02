import 'package:call2sex/GuestProfile.dart';
import 'package:call2sex/WorkerList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Wallet.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

    Future<bool> _onBackPressed() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Are you sure?'),
              content: Text('You are going to exit the application!!'),
              actions: <Widget>[
                FlatButton(
                  child: Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('YES'),
                  onPressed: () {
                    //check?Navigator.pop(context):
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                ),
              ],
            );
          });
    }
    final List<Widget> _children = [
      Worker(),
      Wallet(),
      GuestProfile(),
    ];

    @override
    Widget build(BuildContext context) {
      return WillPopScope(onWillPop: _onBackPressed,
        child: Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blueGrey[900],
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1,
                      colors: <Color>[
                        Colors.redAccent,
                        Colors.orangeAccent
                      ],
                      tileMode: TileMode.repeated,
                    ).createShader(bounds);
                  },
                  child: Icon(Icons.dashboard),
                ),
                icon: new Icon(Icons.home),
                title: new Text('Home',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
              BottomNavigationBarItem(
                activeIcon: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1.0,
                      colors: <Color>[
                        Colors.redAccent,
                        Colors.orangeAccent
                      ],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: Icon(Icons.next_week),
                ),
                icon: new Icon(Icons.account_balance_wallet),
                title: new Text('Wallet',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
              ),

              BottomNavigationBarItem(
                  activeIcon: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return RadialGradient(
                        center: Alignment.topLeft,
                        radius: 1.0,
                        colors: <Color>[
                          Colors.redAccent,
                          Colors.orangeAccent
                        ],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds);
                    },
                    child: Icon(Icons.account_circle),
                  ),
                  icon: Icon(Icons.person),
                  title: Text('My Account',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)),
            ],
          ),
        ),
      );
    }


}

