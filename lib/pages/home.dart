import 'package:flutter/material.dart';
import 'package:lab_4_mobile/models/lesson.dart';
import 'package:lab_4_mobile/pages/lessonPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
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


class _HomeState extends State<Home> {
  Map routeData = {};
  int learnedQuantity;
  int _currentIndex = 0;
  List<int> _history = [0];


  void setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('learnedQuantity', learnedQuantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    Map routeData = ModalRoute
        .of(context)
        .settings
        .arguments;
    List<Lesson> allLessons = routeData['lessons'];
    int quantity = routeData['quantity'];
    learnedQuantity = quantity;
    setData();
    List<Color> colors = [];
    for (int i = 0; i<allLessons.length - quantity; i++) {
      if(i == 0) {
        colors.add(Colors.black);
      } else {
        colors.add(Colors.grey);
      }
    }
    // String login = routeData['login'];
    // String message = routeData['oldUser'] ? "Hello again, $login" : "Hello, $login";
    // print(message);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text("Home"),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView.builder(
          itemCount: allLessons.length - quantity,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: (){
                    if (index == 0) {
                      Navigator.of(context).push(_createRoute({
                        "lessons": allLessons,
                        "index": index + quantity,
                      }));
                    }
                  },
                  title: Text(
                      allLessons[index + quantity].title,
                      style: TextStyle(
                        color: colors[index],
                      ),
                  ),
                ),
              ),
            );
          },
        ),
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

