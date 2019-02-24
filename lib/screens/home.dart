import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'browseflight.dart';
import 'package:flutter/cupertino.dart';

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
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          JumpingDotsProgressIndicator(
            dotSpacing: 3.0,
            milliseconds: 200,
            color: Colors.white,
            fontSize: 100.0,
          ),
          Container(
            margin: EdgeInsets.only(top: 200.0),
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
                          Text("TravelNow", style: TextStyle(fontSize: 25.0)),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
