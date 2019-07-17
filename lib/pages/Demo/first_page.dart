import 'package:flutter/material.dart';
import 'userLoggedInEvent.dart';


class FirstPage extends StatelessWidget {
  String text = '我是触发事件,通过Bus传递';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){
          eventBus.fire(new UserLoggedInEvent(text));
        },
        child: RaisedButton(
          child: Text("点击触发"),
        ),
      ),
    );
  }
}
