import 'package:quizapp/services/db.dart';

import 'models.dart';

/// Static global state
class Global {
  // App data
  static final String title = 'Quiz App';

  // Data models
  static final Map models = {
    Topic: (data) => Topic.fromMap(data),
    Quiz: (data) => Quiz.fromMap(data),
    Report: (data) => Report.fromMap(data),
  };

  // Firestore references for writes
  static final Collection<Topic> topicsRef = Collection<Topic>(path: 'topics');
  static final UserData<Report> reportRef = UserData<Report>(collection: 'reports');
  
}