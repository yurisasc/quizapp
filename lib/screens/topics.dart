import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/screens/quiz.dart';
import 'package:quizapp/services/services.dart';
import 'package:quizapp/shared/progress_bar.dart';
import 'package:quizapp/shared/shared.dart';

class TopicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Global.topicsRef.getData(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasData) {
          List<Topic> topics = snap.data;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Text('Topics'),
              actions: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.userCircle,
                      color: Colors.pink[200]),
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                ),
              ],
            ),
            drawer: TopicDrawer(topics: snap.data),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisCount: 2,
              children: topics.map((topic) => TopicItem(topic: topic)).toList(),
            ),
            bottomNavigationBar: AppBottomNav(),
          );
        } else {
          return LoadingScreen();
        }
      },
    );
  }
}

class TopicItem extends StatelessWidget {
  final Topic topic;

  const TopicItem({Key key, this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: topic.img,

        /// Needed to fix the overflow
        /// (from https://github.com/flutter/flutter/issues/27320)
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          return SingleChildScrollView(
            child: fromHeroContext.widget,
          );
        },

        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => TopicScreen(topic: topic),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/covers/${topic.img}',
                  fit: BoxFit.contain,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          topic.title,
                          style: TextStyle(
                              height: 1.5, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                    ),
                  ],
                ),
                TopicProgress(topic: topic),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopicScreen extends StatelessWidget {
  final Topic topic;

  TopicScreen({Key key, this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Hero(
            tag: topic.img,

            /// Needed to fix the overflow
            /// (from https://github.com/flutter/flutter/issues/27320)
            flightShuttleBuilder: (
                BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext,
                ) {
              return SingleChildScrollView(
                child: fromHeroContext.widget,
              );
            },

            child: Image.asset(
              'assets/covers/${topic.img}',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Text(
            topic.title,
            style:
                TextStyle(height: 2, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          QuizList(topic: topic),
        ],
      ),
    );
  }
}

class QuizList extends StatelessWidget {
  final Topic topic;

  QuizList({Key key, this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: topic.quizzes.map((quiz) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        elevation: 4,
        margin: EdgeInsets.all(4),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => QuizScreen(quizId: quiz.id),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                quiz.title,
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                quiz.description,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.subhead,
              ),
              //leading: QuizBadge(topic: topic, quizId: quiz.id),
            ),
          ),
        ),
      );
    }).toList());
  }
}

class TopicDrawer extends StatelessWidget {
  final List<Topic> topics;

  TopicDrawer({Key key, this.topics});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: topics.length,
        itemBuilder: (BuildContext context, int idx) {
          Topic topic = topics[idx];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  topic.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ),
              QuizList(topic: topic),
            ],
          );
        },
        separatorBuilder: ((BuildContext context, int idx) => Divider()),
      ),
    );
  }
}
