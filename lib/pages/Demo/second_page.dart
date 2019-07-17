import 'package:flutter/material.dart';
import 'userLoggedInEvent.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  var result;
  @override
  Widget build(BuildContext context) {
    _listen();
    return Container(
      child: Text("${result}"),
    );
  }

  void _listen(){
    eventBus.on<UserLoggedInEvent>().listen((event){
      setState(() {
        result=event.Text;
      });
    });
  }

}
