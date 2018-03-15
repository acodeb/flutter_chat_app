import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>  with SingleTickerProviderStateMixin {

  Animation<double> _flutterLogoAnimation;
  AnimationController _flutterLogoAnimationController;
  
  final _scaffoldstate = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();

  static final TextEditingController _user = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();

  String get username => _user.text;
  String get password => _pass.text; 

  @override
  void initState() {
    super.initState();
    _flutterLogoAnimationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 500),
    );

    _flutterLogoAnimation = new CurvedAnimation(
      parent: _flutterLogoAnimationController,
      curve: Curves.easeOut,
    );

    _flutterLogoAnimation.addListener(() => this.setState(() {}));
    _flutterLogoAnimationController.forward();
  }

  void onSubmitPressed() {
    var form = _formKey.currentState;

    if (form.validate()) {
      Navigator.of(context).pushNamedAndRemoveUntil('/landingpage', (Route<dynamic> route) => false);
    }
  }

  String userNameValidator(username) {
    if(username == '') {
      return 'Not a Valid Username';
    }
    return null;
  }

  String passwordValidator(password) {
    if(password == '') {
      return 'Not a Valid Password';
    }
    return null;
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
      body: new Container(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          children: <Widget>[
            new Padding(padding: const EdgeInsets.only(top: 20.0),),
            new FlutterLogo(size: _flutterLogoAnimation.value * 120),
            new Padding(padding: const EdgeInsets.only(bottom: 20.0),),
            new Form(
              key: _formKey,
              child: new Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new TextFormField(controller: _user, decoration: new InputDecoration(labelText: 'Enter username'), validator: userNameValidator,),
                  new TextFormField(controller: _pass, decoration: new InputDecoration(labelText: 'Enter password'), obscureText: true, validator: passwordValidator,),
                  new Padding(padding: const EdgeInsets.only(top: 30.0),),
                  new RaisedButton(
                    child: new Text('Submit'),
                    onPressed: onSubmitPressed,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } 
}