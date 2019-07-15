import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/screens/about.dart';
import 'package:quizapp/screens/login.dart';
import 'package:quizapp/screens/profile.dart';
import 'package:quizapp/screens/topics.dart';
import 'package:quizapp/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      /// User data is put into the providers list, allowing all 
      /// widgets to access the data no matter how deep they 
      /// are in the widget tree.
      providers: [
        StreamProvider<FirebaseUser>.value(stream: AuthService().user),
      ],
      child: MaterialApp(
        // Firebase Analytics
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],

        // Named Routes
        routes: {
          '/': (context) => LoginScreen(),
          '/topics': (context) => TopicsScreen(),
          '/profile': (context) => ProfileScreen(),
          '/about': (context) => AboutScreen(),
        },
        
        // Theme
        theme: ThemeData(
          fontFamily: 'Nunito',
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.black87,
          ),
          brightness: Brightness.dark,
          textTheme: TextTheme(
            body1: TextStyle(fontSize: 18),
            body2: TextStyle(fontSize: 16),
            button: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
            headline: TextStyle(fontWeight: FontWeight.bold),
            subhead: TextStyle(color: Colors.grey),
          ),
          buttonTheme: ButtonThemeData(),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Hello World!'));
  }
}
