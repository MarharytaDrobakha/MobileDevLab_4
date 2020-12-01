import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:lab_4_mobile/models/lesson.dart';

class Lessons extends StatefulWidget {

  @override
  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {

  String jsonString = "https://api.jsonbin.io/b/5fc56c3b9abe4f6e7cadb721";
  List<Lesson> lessons = [];
  Map routeData = {};


  Future<void> getLessons() async {

    final response = await http.get(jsonString);

    Map<String, dynamic> json = jsonDecode(response.body);
    List less = json['lessons'];
    for (var k in less) {
      lessons.add(Lesson(k['img'], k['title'], k['text']));
    }

    getLearnerQuantity().then((value) => Navigator.pushNamed(context, "/home", arguments: {
      "lessons": lessons,
      "quantity": value,
    }));
  }

  Future<int> getLearnerQuantity() async {
    String user = routeData["user"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user == prefs.getString('user')) {
      int learnedQuantity = int.parse(prefs.getString('learnedQuantity'));
      return learnedQuantity;
    } else {
      await prefs.setString('user', user);
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    getLessons();
  }

  @override
  Widget build(BuildContext context) {

    routeData = ModalRoute
        .of(context)
        .settings
        .arguments;

    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
            child: SpinKitCircle(
              color: Colors.white,
              size: 50.0,
            )
        ));
  }
}