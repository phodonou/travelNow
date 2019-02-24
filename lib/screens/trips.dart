import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'trip_modules.dart';

class TripsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TripsPageState();
  }
}

class TripsPageState extends State<TripsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE05351),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                trailing: Icon(Icons.trip_origin),
                title: Text('Trip 1'),
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                    return TripsModulePage();
                  }));
                },
              ),
              Divider()
            ],
          )
        ],
      ),
    );
  }
}
