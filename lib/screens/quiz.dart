import 'package:flutter/material.dart';
import 'package:quizapp/services/models.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({this.quizId});
  final String quizId;

  @override
  Widget build(BuildContext context) {
    return LoadingScreen();
  }
}

class QuizBadge extends StatelessWidget {
  Topic topic;
  String quizId;
  QuizBadge({ Key key, this.topic, this.quizId });
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}