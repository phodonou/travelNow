import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:progress_indicators/progress_indicators.dart';

const String _name = "Sam";

@override
class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController, this.isSam});
  final String text;
  bool isSam;
  final AnimationController animationController;

  bool get getSam=> isSam;
  setSam(bool passedSam){
    isSam = passedSam;
  }

  Widget build(BuildContext context) {
    debugPrint('IS SAM $isSam');
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            isSam ? new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(child: new Text(_name[0])),
            ) : Container(),
            new Expanded(
              child: new Column(
                crossAxisAlignment: isSam ? CrossAxisAlignment.start: CrossAxisAlignment.end,
                children: <Widget>[
                  new Text( isSam ?  _name : 'You', style: Theme.of(context).textTheme.subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(text, style: TextStyle(color: Colors.white, fontSize: 15.0),),
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

  @override
    void initState() {
      _handleSubmitted(
        'Hello, Prince. My name is Sam. I will be by your side through your whole travel experience',
        true
      );
      _handleSubmitted(
        'Where are you traveling to?',
        true
      );
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
          JumpingDotsProgressIndicator(
            dotSpacing: 3.0,
            milliseconds: 200,
            color: Colors.white,
            fontSize: 100.0,
          ),
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
                            ? () => _handleSubmitted(_textController.text, false)
                            : null,
                      )
                    : new IconButton(
                        icon: new Icon(Icons.send),
                        onPressed: _isComposing
                            ? () => _handleSubmitted(_textController.text, false)
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

  void _handleSubmitted(String text, bool isSam) {
    _textController.clear();
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
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }
}
