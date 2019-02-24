import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'browseflight.dart';
import 'package:flutter/cupertino.dart';
import 'trips.dart';

class StartTravel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StartTravelState();
  }
}

class StartTravelState extends State<StartTravel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE05351),
      appBar: AppBar(
        backgroundColor: Color(0xFFE05351),
        elevation: 0.0,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: Icon(Icons.card_travel, color: Colors.white,),
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (_){
                    return TripsPage();
                  }
                ));
              },
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          JumpingDotsProgressIndicator(
            dotSpacing: 3.0,
            milliseconds: 200,
            color: Colors.white,
            fontSize: 100.0,
          ),
          Container(
            margin: EdgeInsets.only(top: 150.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 200.0,
                    height: 200.0,
                    child: new RawMaterialButton(
                      fillColor: Color(0xFFF29C9B),
                      shape: new CircleBorder(),
                      elevation: 5.0,
                      onPressed: () {
                        Navigator.of(context)
                            .push(CupertinoPageRoute(builder: (context) {
                          return ChatScreen();
                        }));
                      },
                      child:
                          Text("Travel Now", style: TextStyle(fontSize: 25.0)),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
