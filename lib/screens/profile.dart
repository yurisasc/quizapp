import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/services/auth.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {

    var user = Provider.of<FirebaseUser>(context);
    bool isAnonymous = user != null ? user.isAnonymous : true;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(isAnonymous ? 'Guest' : user.displayName),
      ),
      body: Center(
        child: FlatButton(
          child: Text('logout'),
          color: Colors.red,
          onPressed: () async {
            await auth.signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
        ),
      ),
    );
  }
}
