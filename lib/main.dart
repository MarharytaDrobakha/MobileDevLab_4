import 'package:flutter/material.dart';
import 'package:lab_4_mobile/pages/authorisation.dart';
import 'package:lab_4_mobile/pages/home.dart';
import 'package:lab_4_mobile/pages/learnedLessons.dart';
import 'package:lab_4_mobile/pages/lessonPage.dart';
import 'package:lab_4_mobile/servises/lessons.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Authorization(),
    '/home': (context) => Home(),
    '/lessons': (context) => Lessons(),
    "/learnedLessons": (context) => LearnedLessons(),
  }
));


