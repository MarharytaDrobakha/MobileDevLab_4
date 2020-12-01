import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_4_mobile/models/lesson.dart';


class LessonPage extends StatelessWidget {

  List<Lesson> lessons;
  Map routeData;
  int index;


  LessonPage(Map map) {
    lessons = map['lessons'];
    index = map['index'];
  }

  @override
  Widget build(BuildContext context) {

    // routeData = ModalRoute
    //     .of(context)
    //     .settings
    //     .arguments;
    //
    // lessons = routeData['lessons'];
    // index = routeData['index'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Lesson"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  lessons[index].title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.network(lessons[index].img),
                SizedBox(
                  height: 20,
                ),
                Text(
                  lessons[index].text,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                FlatButton.icon(
                  color: Colors.deepPurple,
                  onPressed: (){
                    Navigator.pushNamed(context, "/home", arguments: {
                      "lessons": lessons,
                      "quantity": index + 1,
                    });
                  },
                  icon: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Learned",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
