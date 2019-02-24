import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:progress_indicators/progress_indicators.dart';

class TripsModulePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TripsModuleState();
  }
}

class TripsModuleState extends State<TripsModulePage> {
  static AudioCache player = new AudioCache();
  String selfConfidence = "audio/self_confidence.mp3";
  String inPlane = "audio/in_plane.mp3";
  String relaxingMusic = "audio/relaxing_music_2.mp3";
  String extraMessage = "";
  final messages = [
    'As You Pack',
    "While You're on the plane",
    "For Panic attacks while abroad"
  ];
  final List<SimpleDialogOption> checkListDefault = [
    SimpleDialogOption(
      child: Text('Pack passport'),
    ),
    SimpleDialogOption(
      child: Text('Call dog sitter'),
    ),
    SimpleDialogOption(
      child: Text('Pack flight tickets'),
    ),
    SimpleDialogOption(
      child: Text('Lock Doors'),
    )
  ];
  TextEditingController _cont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE05351),
      appBar: AppBar(
        backgroundColor: Color(0xFFE05351),
        elevation: 0.0,
      ),
      body: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return Center(
                child: Column(
                  children: <Widget>[
                    JumpingDotsProgressIndicator(
                      dotSpacing: 3.0,
                      milliseconds: 200,
                      color: Colors.white,
                      fontSize: 100.0,
                    ),
                    Text(
                      messages[index],
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      height: 115.0,
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Image.network(
                          "https://www.mynewsletterbuilder.com/ex/template_content_corner/ex18/images/packing.gif",
                          fit: BoxFit.fill,
                        ),
                      ),
                      onTap: () {
                        //play songs
                        player.play(selfConfidence);
                        showDialog(
                            context: context,
                            builder: (_) {
                              return SimpleDialog(
                                children: checkListDefault,
                                title: Column(
                                  children: <Widget>[
                                    OutlineButton(
                                      borderSide: BorderSide(
                                          color: Color(0xFFFCD7E1), width: 2.0),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return SimpleDialog(
                                                children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.0),
                                                    child: TextField(
                                                      controller: _cont,
                                                    ),
                                                  ),
                                                  ButtonBar(
                                                    children: <Widget>[
                                                      RaisedButton(
                                                        child: Text('OK'),
                                                        onPressed: () {
                                                          checkListDefault.add(
                                                              SimpleDialogOption(
                                                            child: Text(
                                                                _cont.text),
                                                          ));
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Icon(Icons.add),
                                      color: Color(0xFFF08A5D),
                                    ),
                                    Text('Create a checklist')
                                  ],
                                ),
                              );
                            });
                      },
                    )
                  ],
                ),
              );
              break;
            case 1:
              return Center(
                child: Column(
                  children: <Widget>[
                    JumpingDotsProgressIndicator(
                      dotSpacing: 3.0,
                      milliseconds: 200,
                      color: Colors.white,
                      fontSize: 100.0,
                    ),
                    Text(
                      messages[index],
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      extraMessage,
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 125.0,
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Image.network(
                          "https://www.telegraph.co.uk/content/dam/Travel/2018/January/white-plane-sky.jpg?imwidth=450",
                          fit: BoxFit.fill,
                        ),
                      ),
                      onTap: () {
                        player.play(inPlane);
                        setState(() {
                          extraMessage = 'Close Your Eyes';
                        });
                      },
                    )
                  ],
                ),
              );
              break;
            case 2:
              return Center(
                child: Column(
                  children: <Widget>[
                    JumpingDotsProgressIndicator(
                      dotSpacing: 3.0,
                      milliseconds: 200,
                      color: Colors.white,
                      fontSize: 100.0,
                    ),
                    Text(
                      messages[index],
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Everything will be okay',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Breathe',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Image.network(
                          "https://i.ytimg.com/vi/lFcSrYw-ARY/maxresdefault.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                      onTap: () {
                        player.play(inPlane);
                      },
                    )
                  ],
                ),
              );
              break;
            default:
          }
        },
        itemCount: 3,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
}
