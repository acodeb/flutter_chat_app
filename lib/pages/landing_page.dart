import 'package:flutter/material.dart';
import 'chat_message.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _title = 'VAbot App';
  String _message = 'Hello World';
  TextEditingController _textField = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmit(newValue) {
    print('You Entered: $newValue');
    _textField.clear();
    ChatMessage message = new ChatMessage(newValue, 'user');

    setState(() {
      _messages.insert(0, message);
      _messages.insert(0, new ChatMessage(newValue, 'server'));
    });
  }

  Widget _textBoxView() {
    return new IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration: new InputDecoration.collapsed(hintText: 'Enter something'),
                controller: _textField,
                onSubmitted: (newValue) => _handleSubmit(newValue),
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => _handleSubmit(_textField.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listView() {
    return new Column(
      children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
        new Divider(height: 1.0,),
        new Container(
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: _textBoxView(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: _title,
      home: new Scaffold(
        drawer: new Drawer(elevation: 20.0,),
        appBar: new AppBar(
          title: new Text(_title),
          centerTitle: false,
          //backgroundColor: Colors.red,
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.exit_to_app), onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
            },),
          ],
        ),
        body: _listView(),
      ),
    );
  }
}