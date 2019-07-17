import 'package:flutter/material.dart';
import 'first_page.dart';
import 'second_page.dart';

class EventBusDemo extends StatefulWidget {
  @override
  _EventBusDemoState createState() => _EventBusDemoState();
}

class _EventBusDemoState extends State<EventBusDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EventBusDemo"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FirstPage(),
            SecondPage()
          ],
        ),
      ),
    );
  }
}
