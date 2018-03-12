import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldstate = new GlobalKey<ScaffoldState>();
  static final TextEditingController _user = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();

  String get username => _user.text;
  String get password => _pass.text; 

  void onSubmitPressed() {
    print('Login with: $username and password: $password');
    //validateCredentials();
    Navigator.of(context).pushNamedAndRemoveUntil('/landingpage', (Route<dynamic> route) => false);
  }

  void validateCredentials() {
    _scaffoldstate.currentState.showSnackBar(new SnackBar(
      content: new Text('username: $username, password: $password'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldstate,
      //drawer: new Drawer(elevation: 20.0,),
      appBar: new AppBar(
        centerTitle: false,
        title: new Text('VAbot App'),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          child: new Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Login', style: new TextStyle(color: Colors.blue[300], fontSize: 50.0),),
              new TextFormField(controller: _user, decoration: new InputDecoration(hintText: 'Enter username'),),
              new TextFormField(controller: _pass, decoration: new InputDecoration(hintText: 'Enter password'), obscureText: true,),
              new RaisedButton(
                child: new Text('Submit'), 
                onPressed: onSubmitPressed,
              )
            ],
          ),
        ),
      ),
    );
  } 
}