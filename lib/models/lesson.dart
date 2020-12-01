import 'package:http/http.dart' as http;

class Lesson {

  final String img;
  final String title;
  final String text;


  Lesson(this.img, this.title, this.text);

  @override
  String toString() {
    return 'Lesson{img: $img, title: $title, text: $text}';
  }
}
