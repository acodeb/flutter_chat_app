import 'package:flutter/material.dart';

class CardMessage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Container(
        width: 60.0,
        height: 220.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          image: new DecorationImage(image: new AssetImage('assets/img.jpg'), fit: BoxFit.fill,),
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('Credit Card', style: new TextStyle(color: Colors.white, fontSize: 30.0,),),
          ],
        ),
      ),
    );
  }
}