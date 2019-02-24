import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

const String _name = "Sam";
bool travelAcco = false;

@override
class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController, this.isSam});
  final String text;
  bool isSam;
  final AnimationController animationController;

  bool get getSam => isSam;
  setSam(bool passedSam) {
    isSam = passedSam;
  }

  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            isSam
                ? new Container(
                    margin: const EdgeInsets.only(right: 16.0),
                    child: new CircleAvatar(child: new Text(_name[0])),
                  )
                : Container(),
            new Expanded(
              child: new Column(
                crossAxisAlignment:
                    isSam ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: <Widget>[
                  new Text(isSam ? _name : 'You',
                      style: Theme.of(context).textTheme.subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;
  int _samCounter;

  Map<String, String> browseData = {};

  @override
  void initState() {
    _samCounter = 0;
    _handleSubmitted(
        'Hello, Prince. My name is Sam. I will be by your side throughout your whole travel experience.',
        true);
    _handleSubmitted('Where are you traveling to?', true);
    //browseDataPost({'destination':'Chicago', 'origin': 'Urbana', 'date': '2019-02-28', 'accommodation': 'true', 'minRating': '3'});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(0xFFE05351),
        appBar: AppBar(
          backgroundColor: Color(0xFFE05351),
          elevation: 0.0,
        ),
        body: new Column(children: <Widget>[
          new Flexible(
              child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          )),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ]));
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                // onSubmitted: _isComposing ? _handleSubmitted : null,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? new CupertinoButton(
                        child: new Text("Send"),
                        onPressed: _isComposing
                            ? () =>
                                _handleSubmitted(_textController.text, false)
                            : null,
                      )
                    : new IconButton(
                        icon: new Icon(Icons.send),
                        onPressed: _isComposing
                            ? () =>
                                _handleSubmitted(_textController.text, false)
                            : null,
                      )),
          ]),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border:
                      new Border(top: new BorderSide(color: Colors.grey[200])))
              : null),
    );
  }

  void _handleSubmitted(
    String text,
    bool isSam,
  ) async {
    _textController.clear();
    // debugPrint('IS SAM123  $isSam');
    if (isSam) {
      //responding to city inquiry
      _samCounter += 1;
      //user just sent something
      setState(() {
        _isComposing = false;
      });
      ChatMessage message = new ChatMessage(
        text: text,
        animationController: new AnimationController(
          duration: new Duration(milliseconds: 700),
          vsync: this,
        ),
      );
      message.setSam(isSam);
      setState(() {
        _messages.insert(0, message);
      });
      message.animationController.forward();
    } else {
      //user just sent something
      setState(() {
        _isComposing = false;
      });
      ChatMessage message = new ChatMessage(
        text: text,
        animationController: new AnimationController(
          duration: new Duration(milliseconds: 700),
          vsync: this,
        ),
      );
      message.setSam(isSam);
      setState(() {
        _messages.insert(0, message);
      });
      message.animationController.forward();
      //Sam needs to respond
      switch (_samCounter) {
        case 2:
          browseData['destination'] = text;
          _handleSubmitted('Where are you travelling from?', true);
          break;
        case 3:
          browseData['origin'] = text;
          _handleSubmitted('Ready to continue?', true);
          await showDialog(
              context: context,
              builder: (_) {
                return SimpleDialog(
                  title: Text('Please Pick a date for your travel'),
                  children: <Widget>[
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          color: Color(0xFFE05351),
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    )
                  ],
                );
              });
          DateTime dateDue = await showDatePicker(
            context: context,
            firstDate: DateTime.parse("2018-12-27 00:00:00"),
            lastDate: DateTime.parse("3019-14-01 00:00:00"),
            initialDate: DateTime.now(),
          );
          browseData['date'] =
              dateDue == null ? null : dateDue.toString().split(' ')[0];
          break;
        case 4:
          _handleSubmitted(
              'And Prince, would you like accommodation? (Yes or No)', true);
          break;
        case 5:
          if ((text.trim().toLowerCase() == 'yes') ||
              (text.trim().toLowerCase() == 'no')) {
            if (text.trim().toLowerCase() == 'yes') {
              travelAcco = true;
            } else {
              travelAcco = false;
            }
          } else {
            travelAcco = false;
            _handleSubmitted("I don't understand that input", true);
          }
          browseData['accommodation'] = travelAcco.toString();
          if (travelAcco) {
            _handleSubmitted(
                'Sure Prince. What is the minimum rating you would want for a hotel?(number)',
                true);
          } else {
            _handleSubmitted(
                "Okay. So is it fine if I don't book accommodation?", true);
          }
          break;
        case 6:
          if (travelAcco) {
            browseData['minRating'] = text.toString();
          }
          _handleSubmitted('Now Searching for bundles...', true);
          print(browseData);
          browseDataPost(browseData);
          break;
        default:
      }
    }
  }

  browseDataPost(Map<String, String> data) async {
    Response response = await post('http://172.16.26.215:5000/book', body: data);
    var resMess = json.decode(response.body);

    //print('Flights: ${resMess['flights'][0]}');
    String flightString = "";
    for(Map flight in resMess['flights']){
      flightString += "${flight['offerItems'][0]['services'][0]['segments']}\n";
    }
    _handleSubmitted(flightString, true);

    String hotelString = "";
    for(Map hotel in resMess['hotels']){
      hotelString += "${hotel['hotel']['name']}\n";
    }
    _handleSubmitted(hotelString, true);

    // print('Hotels: ${resMess['hotels']}');
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }
}

