import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/services/auth.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/topics');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlutterLogo(size: 150),
              Text(
                'Login to Start',
                style: Theme.of(context).textTheme.headline,
              ),
              LoginButton(
                text: 'LOGIN WITH GOOGLE',
                icon: FontAwesomeIcons.google,
                color: Colors.black45,
                loginMethod: () => auth.googleSignIn(),
              ),
              LoginButton(
                text: 'Continue as Guest',
                loginMethod: () => auth.anonLogin(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton({this.text, this.icon, this.color, this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: icon != null
          ? FlatButton.icon(
              padding: EdgeInsets.all(30),
              icon: Icon(icon, color: Colors.white),
              color: color,
              onPressed: () async {
                var user = await loginMethod();
                if (user != null) {
                  Navigator.pushReplacementNamed(context, '/topics');
                }
              },
              label: Text(this.text),
            )
          : FlatButton(
              onPressed: () async {
                var user = await loginMethod();
                if (user != null) {
                  Navigator.pushReplacementNamed(context, '/topics');
                }
              },
              child: Text(this.text),
            ),
    );
  }
}
