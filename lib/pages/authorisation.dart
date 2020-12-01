import 'package:flutter/material.dart';

class Authorization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    String login;
    String pass;

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
                onChanged: (String value){
                  login = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                onChanged: (value){
                  pass = value.toString();
                },
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.deepPurple,
                child: Text(
                    'ENTER',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/lessons', arguments: {
                    'user': login
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}