import 'package:flutter/material.dart';
import 'chat_message.dart';
import 'package:chatapp/pages/card_message.dart';
import 'package:speech_recognition/speech_recognition.dart';
//import 'speech_recognition.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _title = 'VAbot App';
  TextEditingController _textField = new TextEditingController();
  final List<Widget> _messages = <Widget>[];
  
  bool _authorized = false;
  bool _isListening = false;
  SpeechRecognition _speech;
  String _currentLocale = 'en_US';
  String _transcription = '';

  void _handleSubmit(newValue) {
    _textField.clear();
    if(newValue.isNotEmpty){
      ChatMessage message = new ChatMessage(newValue, 'User');

      setState(() {
        _messages.insert(0, message);
        _messages.insert(0, new ChatMessage(newValue, 'server'));

      });
    }
  }

  @override
  void initState() {
    super.initState();
    _messages.insert(0, new CardMessage());
    activateSpeechRecognizer();
  }

  @override
  void dispose(){
    super.dispose();
  }

  void activateSpeechRecognizer() {
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.activate().then((res) => setState(()  {
      print('RES -> $res');
      _authorized = res;
    }));
  }

  void start() {
    SystemSound.play(SystemSoundType.click);
    print('START -> $_currentLocale');
    _speech.listen(locale: _currentLocale).then((result) => setState(() => _authorized = result));
  }

  void stop() {
    print('STOP');
    _speech.stop().then((result) => setState(() {
      print('STOP -> $result');
      _isListening = result;
      //speechToText();
    }));
  }

  void cancel() =>
    _speech.cancel().then((result) => setState(() {
        print('CANCEL -> $result');
        _isListening = result;
        _textField.clear();
  }));

  void onSpeechAvailability(bool result) =>
      setState(() {
        print('onSpeechAvailability -> $result');
        _authorized = result;
      });

  void onCurrentLocale(String locale) =>
      setState(() {
        print('onCurrentLocale -> $locale');
        _currentLocale = 'en_US';
      });

  void onRecognitionStarted() => setState(() {
    print('onRecognitionStarted');
    _isListening = true;
  });

  void onRecognitionResult(String text) => setState(() {
    _transcription = text;
    _textField.text = text;
  });

  void onRecognitionComplete() => setState(() {
    print('onRecognitionComplete');
    _isListening = false;
    _textField.clear();
    speechToText();
  });

  void speechToText() {
    print('speechToText -> $_transcription');
    if (_transcription.isNotEmpty){
      ChatMessage message = new ChatMessage(_transcription, 'User');
      _textField.clear();
      setState(() {
        _textField.clear();
        _messages.insert(0, message);
        _transcription = '';
      });
    }
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
            /* new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.mic),
                onPressed: () { start();},
              ),
            ), */
            new GestureDetector(
              onTapDown: (d) => start(),
              onTapUp: (d) => stop(),
              child: new Icon(Icons.mic),
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