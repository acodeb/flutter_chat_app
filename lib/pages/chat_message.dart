import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String _text;
  final String _from;
  ChatMessage(this._text, this._from);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: _from != 'server' ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: new Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(const Radius.circular(15.0),),
                /*border: new Border(
                  top: new BorderSide(width: 10.0, color: _from == 'server' ? Colors.grey[300] : Colors.blue[300]),
                  bottom: new BorderSide(width: 10.0, color: _from == 'server' ? Colors.grey[300] : Colors.blue[300]),
                  left: new BorderSide(width: 10.0, color: _from == 'server' ? Colors.grey[300] : Colors.blue[300]),
                  right: new BorderSide(width: 10.0, color: _from == 'server' ? Colors.grey[300] : Colors.blue[300]),
                ),*/
                color: _from == 'server' ? Colors.grey[300] : Colors.blue[300],

              ),
              padding: new EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
              child: new Text(_text, style: new TextStyle(fontSize: 18.0, ),),
            ),
          ),
        ],
      ),
    );
  }
}