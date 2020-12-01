import 'package:flutter/material.dart';
import 'package:lab_4_mobile/models/lesson.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lessonPage.dart';

class LearnedLessons extends StatefulWidget {
  @override
  _LearnedLessonsState createState() => _LearnedLessonsState();
}

Route _createRoute(Map arguments) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => LessonPage(arguments),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class _LearnedLessonsState extends State<LearnedLessons> {
  Map routeData = {};
  int learnedQuantity;
  int _currentIndex = 0;
  List<int> _history = [0];
  List<Lesson> allLessons;
  int quantity;
  Widget card;


  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    learnedQuantity = int.parse(prefs.getString('learnedQuantity'));
    await prefs.setString('learnedQuantity', learnedQuantity.toString());
  }

  @override
  Widget build(BuildContext context) {


    Map routeData = ModalRoute
        .of(context)
        .settings
        .arguments;
    allLessons = routeData['lessons'];
    quantity = routeData['quantity'];
    if (quantity > 0) {
      card = ListView.builder(
        itemCount: quantity,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(_createRoute({
                    "lessons": allLessons,
                    "index": index,
                  }));
                },
                title: Text(
                  allLessons[index].title,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      card = Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text ("No learned lessons"),
      );
    }
    // String login = routeData['login'];
    // String message = routeData['oldUser'] ? "Hello again, $login" : "Hello, $login";
    // print(message);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text("Learned lessons"),
          centerTitle: true,
          elevation: 0,
        ),
        body: card,
        bottomNavigationBar: BottomNavigationBar(
          //backgroundColor: Colors.deepPurple,
            items: const <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.done),
                label: "Learned",
              )
            ],
            onTap: (int index) {
              _history.add(index);
              setState(() => _currentIndex = index);
              if (index == 0) {
                Navigator.pushNamed(context, "/home", arguments: {
                  "lessons": allLessons,
                  "quantity": quantity,
                });
              } else {
                Navigator.pushNamed(context, "/learnedLessons", arguments: {
                  "lessons": allLessons,
                  "quantity": quantity,
                });
              }
            }
        )
    );
  }
}

