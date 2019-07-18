class Option {
  String value;
  String detail;
  bool correct;

  Option({this.correct, this.value, this.detail});

  factory Option.fromMap(Map data) {
    return Option(
      correct: data['correct'],
      value: data['value'],
      detail: data['detail'] ?? '',
    );
  }
}

class Question {
  String text;
  List<Option> options;

  Question({this.options, this.text});

  factory Question.fromMap(Map data) {
    return Question(
      text: data['text'] ?? '',
      options: (data['options'] as List ?? [])
          .map((v) => Option.fromMap(v))
          .toList(),
    );
  }
}

class Quiz {
  String id;
  String description;
  List<Question> questions;
  String title;
  String topic;

  Quiz({this.id, this.description, this.questions, this.title, this.topic});

  factory Quiz.fromMap(Map data) {
    return Quiz(
      id: data['id'] ?? '',
      description: data['description'] ?? '',
      questions: (data['questions'] as List ?? [])
          .map((v) => Question.fromMap(v))
          .toList(),
      title: data['title'] ?? '',
      topic: data['topic'] ?? '',
    );
  }
}

class Topic {
  String id;
  String img;
  List<Quiz> quizzes;
  String title;

  Topic({this.id, this.img, this.quizzes, this.title});

  factory Topic.fromMap(Map data) {
    return Topic(
      id: data['id'] ?? '',
      img: data['img'] ?? '',
      quizzes:
          (data['quizzes'] as List ?? []).map((v) => Quiz.fromMap(v)).toList(),
      title: data['title'] ?? '',
    );
  }
}

class Report {
  String uid;
  int total;
  Map topics;

  Report({this.uid, this.topics, this.total});

  factory Report.fromMap(Map data) {
    return Report(
      uid: data['uid'] ?? '',
      total: data['total'] ?? 0,
      topics: data['topics'] ?? {},
    );
  }
}
